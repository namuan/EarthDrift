import Foundation
import CoreLocation

enum Biome: String, CaseIterable, Codable {
    case ocean
    case coastal
    case river
    case forest
    case desert
    case mountain
    case urban
    case arctic
    case grassland
    case wetland

    var baseSoundFile: String {
        switch self {
        case .ocean, .coastal: return "ocean"
        case .river, .forest, .grassland, .wetland: return "forest"
        case .desert: return "desert"
        case .mountain: return "mountain"
        case .urban: return "city"
        case .arctic: return "wind"
        }
    }
}

struct BiomeMix {
    var weights: [Biome: Float]

    init(weights: [Biome: Float]) {
        let total = weights.values.reduce(0, +)
        if total > 0 {
            self.weights = weights.mapValues { $0 / total }
        } else {
            self.weights = weights
        }
    }

    init(single biome: Biome) {
        self.weights = [biome: 1.0]
    }

    static func lerp(from: BiomeMix, to: BiomeMix, fraction: Float) -> BiomeMix {
        let clamped = max(0, min(1, fraction))
        var merged: [Biome: Float] = [:]
        let allBiomes = Set(from.weights.keys).union(to.weights.keys)
        for biome in allBiomes {
            let a = from.weights[biome] ?? 0
            let b = to.weights[biome] ?? 0
            merged[biome] = a + (b - a) * clamped
        }
        return BiomeMix(weights: merged)
    }

    var dominant: Biome? {
        weights.max(by: { $0.value < $1.value })?.key
    }
}
