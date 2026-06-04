@preconcurrency import AVFoundation

@MainActor
final class AudioEngine: ObservableObject {
    @Published var isEnabled = true
    @Published var volume: Float = 0.3

    private let engine = AVAudioEngine()
    private var playerNodes: [AVAudioPlayerNode] = []
    private var currentCategory: RouteCategory?

    func setSoundscape(for category: RouteCategory) {
        guard isEnabled else {
            logDebug("Audio soundscape skipped: audio disabled")
            return
        }
        guard category != currentCategory else {
            logDebug("Audio soundscape skipped: same category '\(category.rawValue)'")
            return
        }

        logInfo("Audio soundscape changing: '\(currentCategory?.rawValue ?? "none")' → '\(category.rawValue)'")
        currentCategory = category
        stopAll()
        playAmbient(for: category)
    }

    func stopAll() {
        guard !playerNodes.isEmpty else { return }

        logDebug("Audio stopped: nodes=\(playerNodes.count)")
        for node in playerNodes {
            node.stop()
        }
        playerNodes.removeAll()
        if engine.isRunning {
            engine.stop()
        }
    }

    private func playAmbient(for category: RouteCategory) {
        let fileName: String
        switch category {
        case .rivers: fileName = "river_ambient"
        case .railways: fileName = "train_ambient"
        case .flights: fileName = "flight_ambient"
        case .trails: fileName = "nature_ambient"
        case .coastlines: fileName = "ocean_ambient"
        case .ancient: fileName = "wind_ambient"
        }

        guard let url = Bundle.module.url(forResource: fileName, withExtension: "mp3", subdirectory: "audio") else {
            logDebug("Audio file not found: '\(fileName).mp3' in bundle.audio — soundscape unavailable")
            return
        }

        do {
            let file = try AVAudioFile(forReading: url)
            let player = AVAudioPlayerNode()
            engine.attach(player)
            engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
            player.volume = volume

            Task {
                await player.scheduleFile(file, at: nil)
                player.play()
            }
            try engine.start()
            player.play()
            playerNodes.append(player)
            logInfo("Audio playing: '\(fileName)' category='\(category.rawValue)' volume=\(String(format: "%.2f", volume))")
        } catch {
            logError("Audio engine error: \(error.localizedDescription) file='\(fileName)'")
        }
    }
}
