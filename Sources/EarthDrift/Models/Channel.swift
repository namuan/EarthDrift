import Foundation
import CoreLocation

struct Channel: Identifiable {
    let id: UUID
    let name: String
    let icon: String
    let routes: [Route]

    init(id: UUID = UUID(), name: String, icon: String, routes: [Route]) {
        self.id = id
        self.name = name
        self.icon = icon
        self.routes = routes
    }
}
