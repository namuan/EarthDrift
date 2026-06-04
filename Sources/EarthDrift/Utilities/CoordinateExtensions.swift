import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    func distance(to other: CLLocationCoordinate2D) -> Double {
        location.distance(from: other.location)
    }

    func bearing(to other: CLLocationCoordinate2D) -> Double {
        let lat1 = latitude * .pi / 180
        let lat2 = other.latitude * .pi / 180
        let dLon = (other.longitude - longitude) * .pi / 180

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        return atan2(y, x) * 180 / .pi
    }

    func interpolated(to other: CLLocationCoordinate2D, fraction: Double) -> CLLocationCoordinate2D {
        let t = max(0, min(1, fraction))
        return CLLocationCoordinate2D(
            latitude: latitude + (other.latitude - latitude) * t,
            longitude: longitude + (other.longitude - longitude) * t
        )
    }
}

func catmullRom(
    p0: CLLocationCoordinate2D,
    p1: CLLocationCoordinate2D,
    p2: CLLocationCoordinate2D,
    p3: CLLocationCoordinate2D,
    t: Double
) -> CLLocationCoordinate2D {
    let t2 = t * t
    let t3 = t2 * t

    let lat = 0.5 * (
        (2 * p1.latitude) +
        (-p0.latitude + p2.latitude) * t +
        (2 * p0.latitude - 5 * p1.latitude + 4 * p2.latitude - p3.latitude) * t2 +
        (-p0.latitude + 3 * p1.latitude - 3 * p2.latitude + p3.latitude) * t3
    )

    let lon = 0.5 * (
        (2 * p1.longitude) +
        (-p0.longitude + p2.longitude) * t +
        (2 * p0.longitude - 5 * p1.longitude + 4 * p2.longitude - p3.longitude) * t2 +
        (-p0.longitude + 3 * p1.longitude - 3 * p2.longitude + p3.longitude) * t3
    )

    return CLLocationCoordinate2D(latitude: lat, longitude: lon)
}

func splineInterpolatedCoordinate(
    coordinates: [CLLocationCoordinate2D],
    progress: Double
) -> CLLocationCoordinate2D {
    guard coordinates.count >= 4 else {
        if coordinates.count == 1 { return coordinates[0] }
        if coordinates.count == 2 {
            return coordinates[0].interpolated(to: coordinates[1], fraction: progress)
        }
        let segments = coordinates.count - 1
        let segment = min(Int(progress * Double(segments)), segments - 1)
        let localT = progress * Double(segments) - Double(segment)
        return coordinates[segment].interpolated(to: coordinates[segment + 1], fraction: localT)
    }

    let segments = coordinates.count - 3
    let segment = min(Int(progress * Double(segments)), segments - 1)
    let localT = max(0, min(1, progress * Double(segments) - Double(segment)))

    let p0 = coordinates[max(0, segment - 1)]
    let p1 = coordinates[segment]
    let p2 = coordinates[segment + 1]
    let p3 = coordinates[min(coordinates.count - 1, segment + 2)]

    return catmullRom(p0: p0, p1: p1, p2: p2, p3: p3, t: localT)
}

func splineBearing(
    coordinates: [CLLocationCoordinate2D],
    progress: Double
) -> Double {
    let current = splineInterpolatedCoordinate(coordinates: coordinates, progress: progress)
    let ahead = splineInterpolatedCoordinate(coordinates: coordinates, progress: min(progress + 0.001, 1.0))
    return current.bearing(to: ahead)
}
