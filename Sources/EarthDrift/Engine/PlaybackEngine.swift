import Foundation
import Observation

private enum PlaybackKeys {
    static let speedMultiplier = "speedMultiplier"
}

@MainActor
@Observable
final class PlaybackEngine {
    var isPlaying = false
    var progress: Double = 0
    var currentRoute: Route?
    var currentChannel: Channel?
    var activeNarration: NarrationPoint?

    var cameraController = CameraController()
    var narrationEngine = NarrationEngine()
    var routeCompletionCount = 0

    var speedMultiplier: Double = {
        let saved = UserDefaults.standard.double(forKey: PlaybackKeys.speedMultiplier)
        return saved > 0 ? saved : 1.0
    }() {
        didSet { UserDefaults.standard.set(speedMultiplier, forKey: PlaybackKeys.speedMultiplier) }
    }

    private var displayLink: Timer?
    private let frameRate: TimeInterval = 1.0 / 30.0
    private var lastUpdateTime: Date = .now
    private var tickCount: Int = 0
    private var logThrottle: Int = 0

    func startPlayback(route: Route, channel: Channel) {
        logInfo("Starting playback: route='\(route.title)' category=\(route.category.rawValue) channel='\(channel.name)' duration=\(Int(route.duration))s altitude=\(Int(route.altitude))m segments=\(route.segments.count) narrationPoints=\(route.narrationPoints.count)")

        currentRoute = route
        currentChannel = channel
        progress = 0
        isPlaying = true
        lastUpdateTime = .now
        tickCount = 0
        logThrottle = 0

        cameraController.setRoute(route)
        narrationEngine.setRoute(route)

        displayLink?.invalidate()
        displayLink = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.tick()
            }
        }

        logDebug("DisplayLink scheduled at \(String(format: "%.0f", 1.0 / frameRate))fps")
    }

    func togglePlayPause() {
        guard currentRoute != nil else {
            logWarning("Toggle play/pause ignored: no route loaded")
            return
        }

        isPlaying.toggle()
        if isPlaying {
            logInfo("Playback resumed: route='\(currentRoute?.title ?? "?")' progress=\(String(format: "%.3f", progress))")
            lastUpdateTime = .now
            displayLink?.invalidate()
            displayLink = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { [weak self] _ in
                Task { @MainActor in
                    self?.tick()
                }
            }
        } else {
            logInfo("Playback paused: route='\(currentRoute?.title ?? "?")' progress=\(String(format: "%.3f", progress)) ticks=\(tickCount)")
            displayLink?.invalidate()
            displayLink = nil
        }
    }

    func stopPlayback() {
        logInfo("Playback stopped: route='\(currentRoute?.title ?? "?")' totalTicks=\(tickCount) completionCount=\(routeCompletionCount)")
        isPlaying = false
        displayLink?.invalidate()
        displayLink = nil
        progress = 0
        currentRoute = nil
        currentChannel = nil
        activeNarration = nil
        tickCount = 0
    }

    private func tick() {
        guard isPlaying, let route = currentRoute else { return }

        let now = Date.now
        let deltaTime = now.timeIntervalSince(lastUpdateTime)
        lastUpdateTime = now

        let progressPerSecond = 1.0 / route.duration
        progress += progressPerSecond * deltaTime * speedMultiplier

        if progress >= 1.0 {
            logInfo("Route completed: route='\(route.title)' totalTicks=\(tickCount + 1) channel='\(currentChannel?.name ?? "?")' routeCompletionCount=\(routeCompletionCount + 1)")
            progress = 0
            activeNarration = nil
            routeCompletionCount += 1
            tickCount = 0
            return
        }

        cameraController.update(progress: progress, deltaTime: deltaTime)
        tickCount += 1

        let narration = narrationEngine.checkNarration(at: progress, coordinate: cameraController.currentCoordinate)
        if narration?.id != activeNarration?.id {
            if let narration {
                logInfo("Narration triggered: title='\(narration.title)' distance=\(Int(cameraController.currentCoordinate.distance(to: narration.coordinate)))m progress=\(String(format: "%.3f", progress))")
            }
            activeNarration = narration
        }

        logThrottle += 1
        if logThrottle >= 90 {
            logDebug("Tick #\(tickCount): progress=\(String(format: "%.4f", progress)) coords=(\(String(format: "%.4f", cameraController.currentCoordinate.latitude)),\(String(format: "%.4f", cameraController.currentCoordinate.longitude))) bearing=\(String(format: "%.1f", cameraController.currentBearing)) altitude=\(String(format: "%.0f", cameraController.currentAltitude))")
            logThrottle = 0
        }
    }
}
