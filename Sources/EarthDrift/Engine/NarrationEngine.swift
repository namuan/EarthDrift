import Foundation
import CoreLocation

struct NarrationEngine {
    private var route: Route?
    private var triggeredIDs: Set<UUID> = []

    mutating func setRoute(_ route: Route) {
        self.route = route
        triggeredIDs = []

        logInfo("Narration route set: '\(route.title)' points=\(route.narrationPoints.count)")
        for point in route.narrationPoints {
            logDebug("Narration point: '\(point.title)' at (\(String(format: "%.4f", point.coordinate.latitude)),\(String(format: "%.4f", point.coordinate.longitude))) triggerRadius=\(Int(point.triggerDistance))m")
        }
    }

    mutating func checkNarration(at progress: Double, coordinate: CLLocationCoordinate2D) -> NarrationPoint? {
        guard let route else { return nil }

        var nearest: (point: NarrationPoint, distance: Double)? = nil
        var triggered: NarrationPoint? = nil

        for point in route.narrationPoints {
            guard !triggeredIDs.contains(point.id) else { continue }
            let distance = coordinate.distance(to: point.coordinate)
            if distance <= point.triggerDistance {
                triggeredIDs.insert(point.id)
                triggered = point
                logInfo("Narration fired: title='\(point.title)' distance=\(Int(distance))m triggerRadius=\(Int(point.triggerDistance))m progress=\(String(format: "%.3f", progress))")
            }
            if nearest == nil || distance < nearest!.distance {
                nearest = (point, distance)
            }
        }

        return triggered
    }
}
