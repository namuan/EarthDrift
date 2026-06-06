import Foundation
import CoreLocation

enum RouteCategory: String, Codable, CaseIterable {
    case rivers = "Rivers"
    case railways = "Railways"
    case flights = "Flights"
    case trails = "Trails"
    case coastlines = "Coastlines"
    case ancient = "Ancient Routes"
    case islandHopping = "Island Hopping"
    case volcanoes = "Volcanoes"

    var defaultAltitude: Double {
        switch self {
        case .rivers: return 3000
        case .railways: return 4000
        case .flights: return 15000
        case .trails: return 2500
        case .coastlines: return 5000
        case .ancient: return 6000
        case .islandHopping: return 5000
        case .volcanoes: return 12000
        }
    }

    var icon: String {
        switch self {
        case .rivers: return "water.waves"
        case .railways: return "train.side.front.car"
        case .flights: return "airplane"
        case .trails: return "figure.hiking"
        case .coastlines: return "beach.umbrella"
        case .ancient: return "scroll"
        case .islandHopping: return "ferry"
        case .volcanoes: return "mountain.2.fill"
        }
    }
}

struct RouteSegment: Identifiable {
    let id: UUID
    let start: CLLocationCoordinate2D
    let end: CLLocationCoordinate2D
    let distanceMeters: Double
    let cumulativeDistance: Double

    init(id: UUID = UUID(), start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, cumulativeDistance: Double) {
        self.id = id
        self.start = start
        self.end = end
        self.distanceMeters = start.distance(to: end)
        self.cumulativeDistance = cumulativeDistance
    }
}

struct Route: Identifiable {
    let id: UUID
    let title: String
    let subtitle: String
    let category: RouteCategory
    let coordinates: [CLLocationCoordinate2D]
    let duration: TimeInterval
    let narrationPoints: [NarrationPoint]
    let segments: [RouteSegment]
    let totalDistance: Double
    let altitude: Double

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        category: RouteCategory,
        coordinates: [CLLocationCoordinate2D],
        duration: TimeInterval = 120,
        narrationPoints: [NarrationPoint] = [],
        altitude: Double? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.coordinates = coordinates
        self.duration = duration
        self.narrationPoints = narrationPoints
        self.altitude = altitude ?? category.defaultAltitude

        var segments: [RouteSegment] = []
        var cumulative: Double = 0
        for i in 0..<(coordinates.count - 1) {
            let seg = RouteSegment(start: coordinates[i], end: coordinates[i + 1], cumulativeDistance: cumulative)
            segments.append(seg)
            cumulative += seg.distanceMeters
        }
        self.segments = segments
        self.totalDistance = max(cumulative, 1)
    }

    func coordinate(at progress: Double) -> CLLocationCoordinate2D {
        let clampedProgress = max(0, min(1, progress))
        let targetDistance = clampedProgress * totalDistance

        guard let segmentIndex = segments.firstIndex(where: { $0.cumulativeDistance + $0.distanceMeters >= targetDistance }) else {
            return coordinates.last ?? coordinates[0]
        }

        let segment = segments[segmentIndex]
        let segmentProgress = max(0, min(1, (targetDistance - segment.cumulativeDistance) / max(segment.distanceMeters, 1)))

        return segment.start.interpolated(to: segment.end, fraction: segmentProgress)
    }

    func bearing(at progress: Double) -> Double {
        let clampedProgress = max(0, min(1, progress))
        let lookAhead = min(clampedProgress + 0.002, 1.0)
        let current = coordinate(at: clampedProgress)
        let ahead = coordinate(at: lookAhead)
        return current.bearing(to: ahead)
    }
}
