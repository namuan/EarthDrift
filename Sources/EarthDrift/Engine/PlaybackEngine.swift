import Foundation
import CoreLocation
import Observation

private enum PlaybackKeys {
    static let speedMultiplier = "speedMultiplier"
    static let luckyDuration = "luckyDuration"
    static let isReversed = "isReversed"
}

@Observable
final class PlaybackEngine: @unchecked Sendable {
    var isPlaying = false
    var progress: Double = 0
    var currentRoute: Route?
    var currentChannel: Channel?
    var activeNarration: NarrationPoint?

    var cameraController = CameraController()
    var narrationEngine = NarrationEngine()
    var audioEngine = AudioEngine()
    var routeCompletionCount = 0
    var isFeelingLucky = false

    private let biomeClassifier = BiomeClassifier()
    private var previousNarrationID: UUID?
    private var lastSoundscapeUpdate: Date = .now
    private let soundscapeUpdateInterval: TimeInterval = 1.0

    var speedMultiplier: Double = {
        let saved = UserDefaults.standard.double(forKey: PlaybackKeys.speedMultiplier)
        return saved > 0 ? saved : 1.0
    }() {
        didSet { UserDefaults.standard.set(speedMultiplier, forKey: PlaybackKeys.speedMultiplier) }
    }

    var isReversed: Bool = UserDefaults.standard.bool(forKey: PlaybackKeys.isReversed) {
        didSet { UserDefaults.standard.set(isReversed, forKey: PlaybackKeys.isReversed) }
    }

    var luckyDuration: Double = {
        let saved = UserDefaults.standard.double(forKey: PlaybackKeys.luckyDuration)
        return saved > 0 ? saved : 30
    }() {
        didSet { UserDefaults.standard.set(luckyDuration, forKey: PlaybackKeys.luckyDuration) }
    }

    private var displayLink: Timer?
    private let frameRate: TimeInterval = 1.0 / 30.0
    private var lastUpdateTime: Date = .now
    private var tickCount: Int = 0
    private var logThrottle: Int = 0
    private nonisolated(unsafe) static var resourcesVerified = false

    func startPlayback(route: Route, channel: Channel) {
        isFeelingLucky = false
        logInfo("Starting playback: route='\(route.title)' category=\(route.category.rawValue) channel='\(channel.name)' duration=\(Int(route.duration))s altitude=\(Int(route.altitude))m segments=\(route.segments.count) narrationPoints=\(route.narrationPoints.count)")

        currentRoute = route
        currentChannel = channel
        progress = 0
        isPlaying = true
        lastUpdateTime = .now
        tickCount = 0
        logThrottle = 0
        previousNarrationID = nil

        cameraController.setRoute(route)
        narrationEngine.setRoute(route)

        if !Self.resourcesVerified {
            audioEngine.verifyResources()
            Self.resourcesVerified = true
        }

        updateSoundscape()

        displayLink?.invalidate()
        displayLink = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { [weak self] _ in
            self?.tick()
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
            updateSoundscape()
            displayLink?.invalidate()
            displayLink = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true) { [weak self] _ in
                self?.tick()
            }
        } else {
            logInfo("Playback paused: route='\(currentRoute?.title ?? "?")' progress=\(String(format: "%.3f", progress)) ticks=\(tickCount)")
            audioEngine.stopAll()
            displayLink?.invalidate()
            displayLink = nil
        }
    }

    func stopPlayback() {
        logInfo("Playback stopped: route='\(currentRoute?.title ?? "?")' totalTicks=\(tickCount) completionCount=\(routeCompletionCount)")
        isPlaying = false
        audioEngine.stopAll()
        displayLink?.invalidate()
        displayLink = nil
        progress = 0
        currentRoute = nil
        currentChannel = nil
        activeNarration = nil
        tickCount = 0
    }

    func feelingLucky() {
        stopPlayback()
        let pick = InterestingLocations.random()
        let orbitRadius = max(pick.altitude * 0.3, 500)
        let orbitCoords = generateOrbit(center: pick.coordinate, radiusMeters: orbitRadius, points: 36)
        let route = Route(
            title: pick.name,
            subtitle: "Random discovery",
            category: .ancient,
            coordinates: orbitCoords,
            duration: luckyDuration,
            altitude: pick.altitude
        )
        let channel = Channel(name: pick.name, icon: "star.fill", routes: [route])
        startPlayback(route: route, channel: channel)
        isFeelingLucky = true
        logInfo("Feeling Lucky: '\(pick.name)' orbit radius=\(Int(orbitRadius))m")
    }

    private func generateOrbit(center: CLLocationCoordinate2D, radiusMeters: Double, points: Int) -> [CLLocationCoordinate2D] {
        let latPerMeter = 1.0 / 111_320.0
        let lngPerMeter = 1.0 / (111_320.0 * cos(center.latitude * .pi / 180.0))

        return (0..<points).map { i in
            let angle = 2.0 * .pi * Double(i) / Double(points)
            let latOffset = radiusMeters * latPerMeter * sin(angle)
            let lngOffset = radiusMeters * lngPerMeter * cos(angle)
            return CLLocationCoordinate2D(
                latitude: center.latitude + latOffset,
                longitude: center.longitude + lngOffset
            )
        }
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
            previousNarrationID = nil
            routeCompletionCount += 1
            tickCount = 0
            return
        }

        let effectiveProgress = isReversed ? (1.0 - progress) : progress
        cameraController.update(progress: effectiveProgress, deltaTime: deltaTime)
        tickCount += 1

        if now.timeIntervalSince(lastSoundscapeUpdate) >= soundscapeUpdateInterval {
            updateSoundscape()
            lastSoundscapeUpdate = now
        }

        let narration = narrationEngine.checkNarration(at: effectiveProgress, coordinate: cameraController.currentCoordinate)
        if narration?.id != previousNarrationID {
            if let narration {
                logInfo("Narration triggered: title='\(narration.title)' distance=\(Int(cameraController.currentCoordinate.distance(to: narration.coordinate)))m progress=\(String(format: "%.3f", effectiveProgress))")
                let sting = narration.eventSting ?? route.category.narrationEventSting
                if let sting {
                    audioEngine.playEventSting(sting)
                }
            }
            previousNarrationID = narration?.id
            activeNarration = narration
        }

        logThrottle += 1
        if logThrottle >= 90 {
            logDebug("Tick #\(tickCount): progress=\(String(format: "%.4f", effectiveProgress)) coords=(\(String(format: "%.4f", cameraController.currentCoordinate.latitude)),\(String(format: "%.4f", cameraController.currentCoordinate.longitude))) bearing=\(String(format: "%.1f", cameraController.currentBearing)) altitude=\(String(format: "%.0f", cameraController.currentAltitude))")
            logThrottle = 0
        }
    }

    private func updateSoundscape() {
        guard let route = currentRoute else { return }
        let mix = biomeClassifier.classify(
            coordinate: cameraController.currentCoordinate,
            altitude: cameraController.currentAltitude,
            routeCategory: route.category
        )
        let profile = SoundProfile(
            from: mix,
            channelVolume: 0.2,
            eventVolume: 0
        )
        logDebug("Soundscape: coord=(\(String(format: "%.3f", cameraController.currentCoordinate.latitude)),\(String(format: "%.3f", cameraController.currentCoordinate.longitude))) altitude=\(String(format: "%.0f", cameraController.currentAltitude)) dominantBiome=\(mix.dominant?.rawValue ?? "none") channel=\(route.category.channelSoundFile ?? "none")")
        audioEngine.updateSoundscape(profile: profile, channelFile: route.category.channelSoundFile)
    }
}
