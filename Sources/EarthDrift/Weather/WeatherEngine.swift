import Foundation
import SwiftUI

enum WeatherEffect: String, CaseIterable, Codable {
    case clear
    case clouds
    case fog
    case storm

    var name: String {
        switch self {
        case .clear: return "Clear"
        case .clouds: return "Clouds"
        case .fog: return "Fog"
        case .storm: return "Storm"
        }
    }

    var icon: String {
        switch self {
        case .clear: return "sun.max.fill"
        case .clouds: return "cloud.fill"
        case .fog: return "cloud.fog.fill"
        case .storm: return "cloud.bolt.fill"
        }
    }

    var next: WeatherEffect {
        let all = Self.allCases
        let idx = all.firstIndex(of: self) ?? 0
        return all[(idx + 1) % all.count]
    }

    var previous: WeatherEffect {
        let all = Self.allCases
        let idx = all.firstIndex(of: self) ?? 0
        return all[(idx - 1 + all.count) % all.count]
    }
}

@MainActor
@Observable
final class WeatherEngine {
    var currentEffect: WeatherEffect = .clear
    var intensity: Double = 1.0

    func cycleForward() {
        currentEffect = currentEffect.next
        logInfo("Weather effect cycled → '\(currentEffect.name)'")
    }

    func cycleBackward() {
        currentEffect = currentEffect.previous
        logInfo("Weather effect cycled ← '\(currentEffect.name)'")
    }
}
