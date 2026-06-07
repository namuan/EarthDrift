import Foundation
import CoreLocation
import MapKit

private enum CameraKeys {
    static let pitch = "cameraPitch"
    static let altitudeMultiplier = "cameraAltitudeMultiplier"
}

@Observable
final class CameraController {
    private(set) var camera = MKMapCamera(
        lookingAtCenter: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.1),
        fromDistance: 10000,
        pitch: 0,
        heading: 0
    )
    var currentCoordinate: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    var currentBearing: Double = 0
    var currentAltitude: Double = 3000

    var pitch: Double = UserDefaults.standard.double(forKey: CameraKeys.pitch) {
        didSet {
            UserDefaults.standard.set(pitch, forKey: CameraKeys.pitch)
            pushCamera()
        }
    }

    var altitudeMultiplier: Double = {
        let saved = UserDefaults.standard.double(forKey: CameraKeys.altitudeMultiplier)
        return saved > 0 ? saved : 1.0
    }() {
        didSet {
            UserDefaults.standard.set(altitudeMultiplier, forKey: CameraKeys.altitudeMultiplier)
            pushCamera()
        }
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
            heading: 0
        )
        mainMapView?.camera = camera

        let interpolationMode = route.coordinates.count >= 4 ? "Catmull-Rom spline" : "linear"
        logInfo("Camera route set: title='\(route.title)' altitude=\(Int(route.altitude))m coordinateCount=\(route.coordinates.count) interpolation=\(interpolationMode) startCoord=(\(String(format: "%.3f", currentCoordinate.latitude)), \(String(format: "%.3f", currentCoordinate.longitude)))")
    }

    func update(progress: Double, deltaTime: TimeInterval) {
        guard let route else {
            logWarning("Camera update skipped: no route set")
            return
        }

        if route.coordinates.count >= 4 {
            currentCoordinate = splineInterpolatedCoordinate(coordinates: route.coordinates, progress: progress)
            currentBearing = splineBearing(coordinates: route.coordinates, progress: progress)
        } else {
            currentCoordinate = route.coordinate(at: progress)
            currentBearing = route.bearing(at: progress)
        }

        pushToMapIfNeeded()
    }

    private func pushToMapIfNeeded() {
        guard mainMapView != nil else { return }
        let newAltitude = currentAltitude * altitudeMultiplier
        if (camera.centerCoordinate.latitude != currentCoordinate.latitude
            || camera.centerCoordinate.longitude != currentCoordinate.longitude
            || camera.altitude != newAltitude
            || camera.pitch != pitch) == false { return }
        pushCamera()
    }

    private func pushCamera() {
        guard let mapView = mainMapView else { return }
        camera.centerCoordinate = currentCoordinate
        camera.altitude = currentAltitude * altitudeMultiplier
        camera.pitch = pitch
        mapView.camera = camera
    }

    func teleportTo(coordinate: CLLocationCoordinate2D, altitude: Double? = nil) {
        route = nil
        if let altitude { currentAltitude = altitude }
        currentCoordinate = coordinate
        currentBearing = 0

        camera = MKMapCamera(
            lookingAtCenter: coordinate,
            fromDistance: currentAltitude * altitudeMultiplier,
            pitch: pitch,
            heading: 0
        )
        mainMapView?.camera = camera

        logInfo("Teleported to: (\(String(format: "%.3f", coordinate.latitude)), \(String(format: "%.3f", coordinate.longitude))) altitude=\(Int(currentAltitude))m")
    }
}
