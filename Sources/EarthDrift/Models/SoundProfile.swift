import Foundation

struct SoundProfile {
    var baseVolumes: [Biome: Float]
    var channelVolume: Float
    var eventVolume: Float

    static let silent = SoundProfile(baseVolumes: [:], channelVolume: 0, eventVolume: 0)

    init(baseVolumes: [Biome: Float] = [:], channelVolume: Float = 0, eventVolume: Float = 0) {
        self.baseVolumes = baseVolumes
        self.channelVolume = channelVolume
        self.eventVolume = eventVolume
    }

    init(from biomeMix: BiomeMix, channelVolume: Float = 0.2, eventVolume: Float = 0) {
        self.baseVolumes = biomeMix.weights.mapValues { $0 * 0.7 }
        self.channelVolume = channelVolume * 0.2
        self.eventVolume = eventVolume * 0.1
    }

    static func lerp(from: SoundProfile, to: SoundProfile, fraction: Float) -> SoundProfile {
        let clamped = max(0, min(1, fraction))
        let fromMix = BiomeMix(weights: from.baseVolumes)
        let toMix = BiomeMix(weights: to.baseVolumes)
        let blendedMix = BiomeMix.lerp(from: fromMix, to: toMix, fraction: clamped)

        let baseVolumes = blendedMix.weights.mapValues { $0 * 0.7 }
        let channelVolume = (from.channelVolume + (to.channelVolume - from.channelVolume) * clamped)
        let eventVolume = (from.eventVolume + (to.eventVolume - from.eventVolume) * clamped)

        return SoundProfile(
            baseVolumes: baseVolumes,
            channelVolume: channelVolume,
            eventVolume: eventVolume
        )
    }
}
