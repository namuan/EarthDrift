import Foundation
import CoreLocation
import MapKit

private enum CameraKeys {
    static let pitch = "cameraPitch"
    static let altitudeMultiplier = "cameraAltitudeMultiplier"
}

@MainActor
@Observable
final class CameraController {
    var camera: MKMapCamera = MKMapCamera() {
        didSet {
            mainMapView?.camera = camera
        }
    }
    var currentCoordinate: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    var currentBearing: Double = 0
    var currentAltitude: Double = 3000

    var pitch: Double = UserDefaults.standard.double(forKey: CameraKeys.pitch) {
        didSet { UserDefaults.standard.set(pitch, forKey: CameraKeys.pitch) }
    }

    var altitudeMultiplier: Double = {
        let saved = UserDefaults.standard.double(forKey: CameraKeys.altitudeMultiplier)
        return saved > 0 ? saved : 1.0
    }() {
        didSet { UserDefaults.standard.set(altitudeMultiplier, forKey: CameraKeys.altitudeMultiplier) }
    }

    weak var mainMapView: MKMapView?

    private var route: Route?

    func setRoute(_ route: Route) {
        self.route = route
        currentAltitude = route.altitude

        if route.coordinates.count >= 4 {
            currentCoordinate = splineInterpolatedCoordinate(coordinates: route.coordinates, progress: 0)
            currentBearing = splineBearing(coordinates: route.coordinates, progress: 0)
        } else {
            currentCoordinate = route.coordinate(at: 0)
            currentBearing = route.bearing(at: 0)
        }
        camera = MKMapCamera(
            lookingAtCenter: currentCoordinate,
            fromDistance: currentAltitude * altitudeMultiplier,
            pitch: pitch,
            heading: currentBearing
        )

        let interpolationMode = route.coordinates.count >= 4 ? "Catmull-Rom spline" : "linear"
        logInfo("Camera route set: title='\(route.title)' altitude=\(Int(route.altitude))m coordinateCount=\(route.coordinates.count) interpolation=\(interpolationMode) startCoord=(\(String(format: "%.3f", currentCoordinate.latitude)), \(String(format: "%.3f", currentCoordinate.longitude))) startBearing=\(String(format: "%.1f", currentBearing))")
    }

    func update(progress: Double, deltaTime: TimeInterval) {
        guard let route else {
            logWarning("Camera update skipped: no route set")
            return
        }

        let prevCoordinate = currentCoordinate
        let prevBearing = currentBearing

        if route.coordinates.count >= 4 {
            currentCoordinate = splineInterpolatedCoordinate(coordinates: route.coordinates, progress: progress)
            currentBearing = splineBearing(coordinates: route.coordinates, progress: progress)
        } else {
            currentCoordinate = route.coordinate(at: progress)
            currentBearing = route.bearing(at: progress)
        }

        let newCamera = MKMapCamera(
            lookingAtCenter: currentCoordinate,
            fromDistance: currentAltitude * altitudeMultiplier,
            pitch: pitch,
            heading: currentBearing
        )

        let distanceMoved = prevCoordinate.distance(to: currentCoordinate)
        let bearingDelta = abs(currentBearing - prevBearing)
        if bearingDelta > 180 { }

        if distanceMoved > 1000 || (bearingDelta > 180 ? abs(bearingDelta - 360) : bearingDelta) > 10 {
            logDebug("Camera updated: coords=(\(String(format: "%.4f", currentCoordinate.latitude)),\(String(format: "%.4f", currentCoordinate.longitude))) bearing=\(String(format: "%.1f", currentBearing)) altitude=\(String(format: "%.0f", currentAltitude))m distanceMoved=\(String(format: "%.0f", distanceMoved))m deltaBearing=\(String(format: "%.1f", bearingDelta > 180 ? abs(bearingDelta - 360) : bearingDelta)) deltaTime=\(String(format: "%.3f", deltaTime))s")
        }

        camera = newCamera
    }
}
