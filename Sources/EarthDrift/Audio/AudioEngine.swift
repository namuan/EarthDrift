@preconcurrency import AVFoundation

final class AudioEngine: ObservableObject, @unchecked Sendable {
    @Published var isEnabled = true
    @Published var volume: Float = 0.3 {
        didSet { applyMasterVolume() }
    }

    private let engine = AVAudioEngine()
    private var basePlayers: [String: AVAudioPlayerNode] = [:]
    private var currentProfile = SoundProfile.silent
    private var targetVolumes: [String: Float] = [:]
    private var currentVolumes: [String: Float] = [:]
    private var channelPlayer: AVAudioPlayerNode?
    private var isShuttingDown = false
    private var pendingEventPlayers = Set<AVAudioPlayerNode>()
    private var crossfadeTask: Task<Void, Never>?

    private let crossfadeDuration: TimeInterval = 2.5
    private let crossfadeSteps = 50

    func updateSoundscape(profile: SoundProfile, channelFile: String?) {
        guard isEnabled else { return }
        isShuttingDown = false
        logInfo("Audio update: biomes=[\(profile.baseVolumes.keys.map(\.rawValue).joined(separator: ","))] channel=\(channelFile ?? "none")")
        currentProfile = profile
        updateBaseLayers(profile: profile)
        updateChannelLayer(channelFile: channelFile, profile: profile)
    }

    func playEventSting(_ fileName: String) {
        guard isEnabled else { return }
        isShuttingDown = false
        logInfo("Event sting requested: '\(fileName)'")
        guard let url = audioURL(for: fileName, subdirectory: "events") else {
            logError("Event sting URL not found: '\(fileName)'")
            return
        }
        ensureEngineRunning()
        guard !isShuttingDown else { return }
        do {
            let file = try AVAudioFile(forReading: url)
            let fileDuration = Double(file.length) / file.processingFormat.sampleRate
            let player = AVAudioPlayerNode()
            engine.attach(player)
            engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
            player.volume = volume * 0.8

            player.scheduleFile(file, at: nil)
            player.play()

            pendingEventPlayers.insert(player)

            let fadeStart = fileDuration - 0.5
            Task { [weak self, weak player] in
                try? await Task.sleep(nanoseconds: UInt64(max(0, fadeStart) * 1_000_000_000))
                self?.fadeOutAndRemove(player: player)
            }

            logInfo("Event sting playing: '\(fileName)'")
        } catch {
            logError("Event sting error: \(error.localizedDescription)")
        }
    }

    func verifyResources() {
        logInfo("=== Audio bundle verification ===")
        let rootUrls = Bundle.module.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        logInfo("  Bundle root: \(rootUrls.count) mp3 files — \(rootUrls.map(\.lastPathComponent).sorted().joined(separator: ", "))")
        logInfo("=== End verification ===")
    }

    func stopAll() {
        isShuttingDown = true
        crossfadeTask?.cancel()
        crossfadeTask = nil

        for player in pendingEventPlayers {
            player.stop()
        }
        pendingEventPlayers.removeAll()

        for (_, player) in basePlayers {
            player.stop()
        }
        for (_, player) in basePlayers {
            engine.disconnectNodeOutput(player)
            engine.detach(player)
        }
        basePlayers.removeAll()
        currentVolumes.removeAll()
        targetVolumes.removeAll()

        if let cp = channelPlayer {
            cp.stop()
            engine.disconnectNodeOutput(cp)
            engine.detach(cp)
            channelPlayer = nil
        }

        if engine.isRunning {
            engine.stop()
        }

        currentProfile = .silent
        logDebug("Audio stopped: all layers detached")
    }

    // MARK: - Private

    private func updateBaseLayers(profile: SoundProfile) {
        let desiredBiomes = Set(profile.baseVolumes.keys)

        for biome in desiredBiomes {
            let soundFile = biome.baseSoundFile
            if basePlayers[soundFile] == nil {
                startBaseLayer(soundFile: soundFile)
            }
            targetVolumes[soundFile] = max(targetVolumes[soundFile] ?? 0, profile.baseVolumes[biome] ?? 0)
        }

        for (soundFile, _) in basePlayers where !desiredBiomes.contains(where: { $0.baseSoundFile == soundFile }) {
            targetVolumes[soundFile] = 0
        }

        startCrossfade()
    }

    private func updateChannelLayer(channelFile: String?, profile: SoundProfile) {
        var currentChannelKey: String?
        if channelPlayer != nil {
            currentChannelKey = channelFile
        }

        if channelFile != currentChannelKey {
            if let cp = channelPlayer {
                cp.stop()
                engine.disconnectNodeOutput(cp)
                engine.detach(cp)
                channelPlayer = nil
            }

            if let cf = channelFile, let url = audioURL(for: cf, subdirectory: "channel") {
                do {
                    let file = try AVAudioFile(forReading: url)
                    let player = AVAudioPlayerNode()
                    engine.attach(player)
                    engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
                    scheduleLooping(player: player, file: file)
                    player.volume = 0
                    player.play()
                    channelPlayer = player
                    currentVolumes["__channel__"] = 0
                } catch {
                    logError("Channel audio error: \(error.localizedDescription)")
                }
            }
        }

        targetVolumes["__channel__"] = profile.channelVolume
        startCrossfade()
    }

    private func startBaseLayer(soundFile: String) {
        guard let url = audioURL(for: soundFile, subdirectory: "base") else {
            logError("Base audio not found: '\(soundFile)'")
            return
        }
        do {
            let file = try AVAudioFile(forReading: url)
            let player = AVAudioPlayerNode()
            engine.attach(player)
            engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
            scheduleLooping(player: player, file: file)
            player.volume = 0.001
            if !engine.isRunning {
                ensureEngineRunning()
            }
            player.play()
            basePlayers[soundFile] = player
            currentVolumes[soundFile] = 0.001
            logInfo("Base layer active: '\(soundFile)'")
        } catch {
            logError("Base audio error: \(error.localizedDescription)")
        }
    }

    private func ensureEngineRunning() {
        guard !engine.isRunning else { return }
        do {
            engine.prepare()
            try engine.start()
            logInfo("Audio engine started successfully")
        } catch {
            logError("Audio engine start failed: \(error.localizedDescription)")
        }
    }

    private func scheduleLooping(player: AVAudioPlayerNode, file: AVAudioFile) {
        guard let buffer = file.toBuffer() else {
            logError("Failed to create buffer from audio file")
            return
        }
        player.scheduleBuffer(buffer, at: nil, options: .loops)
    }

    private func startCrossfade() {
        guard crossfadeTask == nil, !isShuttingDown else { return }
        crossfadeTask = Task { [weak self] in
            guard let self else { return }
            for step in 0..<self.crossfadeSteps {
                guard !self.isShuttingDown, !Task.isCancelled else { return }
                let progress = Float(step + 1) / Float(self.crossfadeSteps)
                let eased = self.easeInOutCubic(progress)

                for key in Set(self.currentVolumes.keys).union(self.targetVolumes.keys) {
                    guard !self.isShuttingDown, !Task.isCancelled else { return }
                    let current = self.currentVolumes[key] ?? 0
                    let target = self.targetVolumes[key] ?? 0
                    let newVol = current + (target - current) * eased
                    self.currentVolumes[key] = newVol

                    if key == "__channel__" {
                        self.channelPlayer?.volume = self.volume * newVol
                    } else if let player = self.basePlayers[key] {
                        player.volume = self.volume * newVol
                    }
                }

                try? await Task.sleep(nanoseconds: UInt64(self.crossfadeDuration / Double(self.crossfadeSteps) * 1_000_000_000))
            }

            guard !self.isShuttingDown, !Task.isCancelled else { return }
            self.crossfadeTask = nil
            self.cleanupSilentBasePlayers()
        }
    }

    private func cleanupSilentBasePlayers() {
        for (key, targetVol) in targetVolumes where targetVol <= 0.001 {
            if let player = basePlayers[key] {
                player.stop()
                engine.disconnectNodeOutput(player)
                engine.detach(player)
                basePlayers.removeValue(forKey: key)
                currentVolumes.removeValue(forKey: key)
            }
        }
        targetVolumes = targetVolumes.filter { $0.value > 0.001 }
    }

    private func fadeOutAndRemove(player: AVAudioPlayerNode?) {
        guard let player, !isShuttingDown else { return }
        let startVol = player.volume
        let totalDuration = 0.5
        let steps = 10

        Task { [weak self, weak player] in
            guard let self, let player else { return }
            for i in 1...steps {
                guard !self.isShuttingDown else { return }
                player.volume = startVol * (1.0 - Float(i) / Float(steps))
                try? await Task.sleep(nanoseconds: UInt64(totalDuration / Double(steps) * 1_000_000_000))
            }
            guard !self.isShuttingDown else { return }
            player.stop()
            self.engine.disconnectNodeOutput(player)
            self.engine.detach(player)
            self.pendingEventPlayers.remove(player)
        }
    }

    private func applyMasterVolume() {
        for (key, player) in basePlayers {
            player.volume = volume * (currentVolumes[key] ?? 0)
        }
        channelPlayer?.volume = volume * (currentVolumes["__channel__"] ?? 0)
        for player in pendingEventPlayers {
            player.volume = volume * 0.8
        }
    }

    private func audioURL(for fileName: String, subdirectory: String) -> URL? {
        if let url = Bundle.module.url(forResource: fileName, withExtension: "mp3", subdirectory: "audio/\(subdirectory)") {
            return url
        }
        if let url = Bundle.module.url(forResource: fileName, withExtension: "mp3", subdirectory: nil) {
            return url
        }
        return nil
    }

    private func easeInOutCubic(_ t: Float) -> Float {
        if t < 0.5 { return 4 * t * t * t }
        return 1 - pow(-2 * t + 2, 3) / 2
    }
}

extension AVAudioFile {
    func toBuffer() -> AVAudioPCMBuffer? {
        guard let buffer = AVAudioPCMBuffer(pcmFormat: processingFormat, frameCapacity: AVAudioFrameCount(length)) else {
            return nil
        }
        do {
            framePosition = 0
            try read(into: buffer)
            return buffer
        } catch {
            return nil
        }
    }
}
