import Foundation
import CoreLocation

struct NarrationPoint: Identifiable, Codable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    let title: String
    let subtitle: String
    let triggerDistance: Double

    init(
        id: UUID = UUID(),
        latitude: Double,
        longitude: Double,
        title: String,
        subtitle: String,
        triggerDistance: Double = 3000
    ) {
        self.id = id
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.title = title
        self.subtitle = subtitle
        self.triggerDistance = triggerDistance
    }

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, triggerDistance, latitude, longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        triggerDistance = try container.decodeIfPresent(Double.self, forKey: .triggerDistance) ?? 3000
        let lat = try container.decode(Double.self, forKey: .latitude)
        let lon = try container.decode(Double.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(triggerDistance, forKey: .triggerDistance)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}
