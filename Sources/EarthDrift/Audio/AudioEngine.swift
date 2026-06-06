@preconcurrency import AVFoundation

@MainActor
final class AudioEngine: ObservableObject {
    @Published var isEnabled = true
    @Published var volume: Float = 0.3 {
        didSet { applyMasterVolume() }
    }

    private let engine = AVAudioEngine()
    private var basePlayers: [String: AVAudioPlayerNode] = [:]
    private var baseFiles: [String: AVAudioFile] = [:]
    private var channelPlayer: AVAudioPlayerNode?
    private var channelFile: AVAudioFile?
    private var currentProfile = SoundProfile.silent
    private var currentBaseBiome: String?
    private var currentChannelFile: String?
    private var crossfadeTimer: Timer?
    private var targetVolumes: [String: Float] = [:]
    private var currentVolumes: [String: Float] = [:]

    private let crossfadeDuration: TimeInterval = 2.5
    private let crossfadeSteps = 50
    private var crossfadeStep = 0

    func updateSoundscape(profile: SoundProfile, channelFile: String?) {
        guard isEnabled else {
            logDebug("Audio soundscape skipped: audio disabled")
            return
        }
        logInfo("Audio update: biomes=[\(profile.baseVolumes.keys.map(\.rawValue).joined(separator: ","))] channel=\(channelFile ?? "none") channelVol=\(String(format: "%.3f", profile.channelVolume))")
        currentProfile = profile
        currentChannelFile = channelFile

        updateBaseLayers(profile: profile)
        updateChannelLayer(channelFile: channelFile, profile: profile)
    }

    func playEventSting(_ fileName: String) {
        guard isEnabled else { return }
        logInfo("Event sting requested: '\(fileName)'")
        guard let url = audioURL(for: fileName, subdirectory: "events") else {
            logError("Event sting URL not found: '\(fileName)'")
            return
        }
        ensureEngineRunning()
        do {
            let file = try AVAudioFile(forReading: url)
            let fileDuration = Double(file.length) / file.processingFormat.sampleRate
            let player = AVAudioPlayerNode()
            engine.attach(player)
            engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
            player.volume = volume * 0.8

            Task {
                await player.scheduleFile(file, at: nil)
                player.play()
            }

            let fadeDuration: TimeInterval = 0.5
            Task { @MainActor [weak self, weak player] in
                try? await Task.sleep(nanoseconds: UInt64((fileDuration - fadeDuration) * 1_000_000_000))
                self?.fadeOutAndRemove(player: player)
            }

            logInfo("Event sting playing: '\(fileName)' duration=\(String(format: "%.1f", fileDuration))s volume=\(String(format: "%.3f", player.volume)) engineRunning=\(engine.isRunning)")
        } catch {
            logError("Event sting error: \(error.localizedDescription) file='\(fileName)'")
        }
    }

    func verifyResources() {
        logInfo("=== Audio bundle verification ===")
        let rootUrls = Bundle.module.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        logInfo("  Bundle root: \(rootUrls.count) mp3 files — \(rootUrls.map(\.lastPathComponent).sorted().joined(separator: ", "))")
        let subdirs = ["audio/base", "audio/channel", "audio/events"]
        for sub in subdirs {
            if let urls = Bundle.module.urls(forResourcesWithExtension: "mp3", subdirectory: sub), !urls.isEmpty {
                logInfo("  \(sub): \(urls.count) files")
            } else {
                logDebug("  \(sub): empty (files at bundle root)")
            }
        }
        logInfo("=== End verification ===")
    }

    func stopAll() {
        crossfadeTimer?.invalidate()
        crossfadeTimer = nil

        for (_, player) in basePlayers {
            player.stop()
            engine.disconnectNodeOutput(player)
            engine.detach(player)
        }
        basePlayers.removeAll()
        baseFiles.removeAll()
        currentVolumes.removeAll()
        targetVolumes.removeAll()

        if let cp = channelPlayer {
            cp.stop()
            engine.disconnectNodeOutput(cp)
            engine.detach(cp)
            channelPlayer = nil
            channelFile = nil
        }

        if engine.isRunning {
            engine.stop()
        }

        currentProfile = .silent
        currentChannelFile = nil
        currentBaseBiome = nil
        logDebug("Audio stopped: all layers detached")
    }

    // MARK: - Private

    private func updateBaseLayers(profile: SoundProfile) {
        let desiredBiomes = Set(profile.baseVolumes.keys)

        for biome in desiredBiomes {
            let soundFile = biome.baseSoundFile
            let targetVol = profile.baseVolumes[biome] ?? 0

            if basePlayers[soundFile] == nil {
                startBaseLayer(soundFile: soundFile, volume: 0)
            }
            targetVolumes[soundFile] = max(targetVolumes[soundFile] ?? 0, targetVol)
        }

        for (soundFile, _) in basePlayers where !desiredBiomes.contains(where: { $0.baseSoundFile == soundFile }) {
            targetVolumes[soundFile] = 0
        }

        startCrossfade()
    }

    private func updateChannelLayer(channelFile: String?, profile: SoundProfile) {
        if channelFile != currentChannelFile {
            if let cp = channelPlayer {
                cp.stop()
                engine.disconnectNodeOutput(cp)
                engine.detach(cp)
                channelPlayer = nil
                self.channelFile = nil
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
                    self.channelFile = file
                    currentVolumes["__channel__"] = 0
                } catch {
                    logError("Channel audio error: \(error.localizedDescription) file='\(cf)'")
                }
            }
        }

        targetVolumes["__channel__"] = profile.channelVolume
        startCrossfade()
    }

    private func startBaseLayer(soundFile: String, volume: Float) {
        guard let url = audioURL(for: soundFile, subdirectory: "base") else {
            logError("Base audio URL not found: '\(soundFile)' — check file exists in Resources/audio/base/")
            return
        }
        logInfo("Starting base layer: '\(soundFile)' url=\(url.lastPathComponent)")
        do {
            let file = try AVAudioFile(forReading: url)
            logDebug("Base file loaded: '\(soundFile)' channels=\(file.fileFormat.channelCount) sampleRate=\(file.fileFormat.sampleRate) length=\(file.length)")
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
            baseFiles[soundFile] = file
            currentVolumes[soundFile] = 0.001
            logInfo("Base layer active: '\(soundFile)' engineRunning=\(engine.isRunning)")
        } catch {
            logError("Base audio error: \(error.localizedDescription) file='\(soundFile)'")
        }
    }

    private func ensureEngineRunning() {
        guard !engine.isRunning else { return }
        do {
            try engine.start()
            logInfo("Audio engine started successfully")
        } catch {
            logError("Audio engine start failed: \(error.localizedDescription)")
        }
    }

    private func scheduleLooping(player: AVAudioPlayerNode, file: AVAudioFile) {
        guard let buffer = file.toBuffer() else {
            logError("Failed to create buffer from audio file: format=\(file.processingFormat) length=\(file.length)")
            return
        }
        player.scheduleBuffer(buffer, at: nil, options: .loops)
        logDebug("Buffer scheduled: frames=\(buffer.frameLength) channels=\(buffer.format.channelCount) sampleRate=\(buffer.format.sampleRate)")
    }

    private func startCrossfade() {
        if crossfadeTimer != nil { return }

        crossfadeStep = 0
        crossfadeTimer?.invalidate()
        crossfadeTimer = Timer.scheduledTimer(withTimeInterval: crossfadeDuration / Double(crossfadeSteps), repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.applyCrossfadeStep()
            }
        }
    }

    private func applyCrossfadeStep() {
        crossfadeStep += 1
        let progress = min(Float(crossfadeStep) / Float(crossfadeSteps), 1.0)
        let eased = easeInOutCubic(progress)

        let allKeys = Set(currentVolumes.keys).union(targetVolumes.keys)

        for key in allKeys {
            let current = currentVolumes[key] ?? 0
            let target = targetVolumes[key] ?? 0
            let newVol = current + (target - current) * eased
            currentVolumes[key] = newVol

            if key == "__channel__" {
                channelPlayer?.volume = volume * newVol
            } else if let player = basePlayers[key] {
                player.volume = volume * newVol
            }
        }

        if crossfadeStep >= crossfadeSteps {
            crossfadeTimer?.invalidate()
            crossfadeTimer = nil
            logInfo("Audio crossfade complete: base=\(basePlayers.keys.sorted().joined(separator: ",")) channel=\(channelPlayer != nil ? "yes" : "no") engineRunning=\(engine.isRunning)")
            for (key, _) in basePlayers {
                let v = basePlayers[key]?.volume ?? -1
                logDebug("  volume[\(key)] = \(String(format: "%.4f", v))")
            }
            cleanupSilentBasePlayers()
        }
    }

    private func cleanupSilentBasePlayers() {
        for (key, targetVol) in targetVolumes where targetVol <= 0.001 {
            if let player = basePlayers[key] {
                player.stop()
                engine.disconnectNodeOutput(player)
                engine.detach(player)
                basePlayers.removeValue(forKey: key)
                baseFiles.removeValue(forKey: key)
                currentVolumes.removeValue(forKey: key)
            }
        }
        targetVolumes = targetVolumes.filter { $0.value > 0.001 }
    }

    private func fadeOutAndRemove(player: AVAudioPlayerNode?) {
        guard let player else { return }
        let startVol = player.volume
        let steps = 10
        Task { @MainActor [weak self, weak player] in
            for step in 1...steps {
                player?.volume = startVol * (1.0 - Float(step) / Float(steps))
                try? await Task.sleep(nanoseconds: 50_000_000)
            }
            guard let self, let player else { return }
            player.stop()
            self.engine.disconnectNodeOutput(player)
            self.engine.detach(player)
        }
    }

    private func applyMasterVolume() {
        for (key, player) in basePlayers {
            player.volume = volume * (currentVolumes[key] ?? 0)
        }
        channelPlayer?.volume = volume * (currentVolumes["__channel__"] ?? 0)
    }

    private func audioURL(for fileName: String, subdirectory: String) -> URL? {
        if let url = Bundle.module.url(forResource: fileName, withExtension: "mp3", subdirectory: "audio/\(subdirectory)") {
            return url
        }
        if let url = Bundle.module.url(forResource: fileName, withExtension: "mp3", subdirectory: nil) {
            return url
        }
        logError("Audio file not found in bundle: '\(fileName).mp3' (tried audio/\(subdirectory)/ and root)")
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
