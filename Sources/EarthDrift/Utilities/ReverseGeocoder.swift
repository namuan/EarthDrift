import Foundation
import CoreLocation

struct GeocodeResult {
    let locality: String?
    let country: String?
    let label: String

    init(placemark: CLPlacemark) {
        locality = placemark.locality ?? placemark.administrativeArea
        country = placemark.country ?? placemark.ocean
        if let locality, let country {
            label = "\(locality), \(country)"
        } else if let locality {
            label = locality
        } else if let country {
            label = country
        } else {
            label = placemark.ocean ?? "Unknown"
        }
    }
}

final class ReverseGeocoder {
    private let geocoder = CLGeocoder()
    private var lastCoordinate: CLLocationCoordinate2D?
    private var lastRequestTime: Date = .distantPast
    private var lastFailTime: Date = .distantPast
    private var pendingRequest: Task<Void, Never>?
    private var cache: [String: GeocodeResult] = [:]

    var throttleDistance: Double = 5000
    var throttleInterval: TimeInterval = 3

    func place(for coordinate: CLLocationCoordinate2D) async -> GeocodeResult? {
        let coordKey = String(format: "%.2f,%.2f", coordinate.latitude, coordinate.longitude)

        if let cached = cache[coordKey] {
            logDebug("Geocode cache hit: '\(cached.label)' for \(coordKey)")
            return cached
        }

        if let last = lastCoordinate {
            let dist = last.distance(to: coordinate)
            logDebug("Geocode throttle check: dist=\(Int(dist))m threshold=\(Int(throttleDistance))m")
            guard dist >= throttleDistance else {
                logDebug("Geocode skipped: distance \(Int(dist))m < \(Int(throttleDistance))m")
                return nil
            }
        } else {
            logDebug("Geocode: first request, no last coordinate")
        }

        let timeSinceLast = Date.now.timeIntervalSince(lastRequestTime)
        logDebug("Geocode throttle check: timeSinceLast=\(String(format: "%.1f", timeSinceLast))s interval=\(String(format: "%.1f", throttleInterval))s")
        guard timeSinceLast >= throttleInterval else {
            logDebug("Geocode skipped: time \(String(format: "%.1f", timeSinceLast))s < \(String(format: "%.1f", throttleInterval))s")
            return nil
        }

        let timeSinceFail = Date.now.timeIntervalSince(lastFailTime)
        if timeSinceFail < 5 {
            logDebug("Geocode skipped: last fail was \(String(format: "%.1f", timeSinceFail))s ago (< 5s)")
            return nil
        }

        lastCoordinate = coordinate
        lastRequestTime = .now

        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        logDebug("Geocode requesting: \(coordKey)")

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let result = GeocodeResult(placemark: placemark)
                logDebug("Geocode response: locality='\(placemark.locality ?? "nil")' adminArea='\(placemark.administrativeArea ?? "nil")' country='\(placemark.country ?? "nil")' ocean='\(placemark.ocean ?? "nil")' → '\(result.label)'")
                cache[coordKey] = result
                return result
            } else {
                logDebug("Geocode response: no placemarks returned")
            }
            lastFailTime = .now
            return nil
        } catch {
            logError("Geocode error: \(error.localizedDescription)")
            lastFailTime = .now
            return nil
        }
    }

    func cancelPending() {
        pendingRequest?.cancel()
        pendingRequest = nil
    }
}
