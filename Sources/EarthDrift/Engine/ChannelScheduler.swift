import Foundation

@MainActor
@Observable
final class ChannelScheduler {
    var channels: [Channel] = [] {
        didSet {
            logInfo("Channels loaded: count=\(channels.count) names=[\(channels.map { "'\($0.name)'(\($0.routes.count) routes)" }.joined(separator: ", "))]")
        }
    }

    var currentChannelIndex: Int = 0
    var currentRouteIndex: Int = 0

    var currentChannel: Channel? {
        guard !channels.isEmpty else { return nil }
        return channels[currentChannelIndex]
    }

    var currentRoute: Route? {
        guard let channel = currentChannel else { return nil }
        guard !channel.routes.isEmpty else { return nil }
        return channel.routes[currentRouteIndex]
    }

    func selectChannel(index: Int) {
        guard index >= 0, index < channels.count else {
            logWarning("Channel select out of bounds: index=\(index) count=\(channels.count)")
            return
        }
        let prevChannel = currentChannel?.name ?? "none"
        let prevRoute = currentRoute?.title ?? "none"
        currentChannelIndex = index
        currentRouteIndex = 0
        let newChannel = currentChannel?.name ?? "?"
        let newRoute = currentRoute?.title ?? "?"
        logInfo("Channel selected: '\(prevChannel)' → '\(newChannel)' (index: 0→\(index)) route: '\(prevRoute)' → '\(newRoute)'")
    }

    func selectChannel(id: UUID) {
        guard let index = channels.firstIndex(where: { $0.id == id }) else {
            logWarning("Channel select by ID failed: id=\(id) not found")
            return
        }
        selectChannel(index: index)
    }

    func advanceToNextRoute() {
        guard let channel = currentChannel, !channel.routes.isEmpty else {
            logWarning("Advance route failed: no channel or no routes")
            return
        }
        let prevIndex = currentRouteIndex
        let prevRoute = currentRoute?.title ?? "?"
        currentRouteIndex = (currentRouteIndex + 1) % channel.routes.count
        let newRoute = currentRoute?.title ?? "?"
        logInfo("Route advanced: channel='\(channel.name)' routeIndex: \(prevIndex)→\(currentRouteIndex)/\(channel.routes.count) route: '\(prevRoute)' → '\(newRoute)'")
    }

    func previousChannel() {
        guard !channels.isEmpty else {
            logWarning("Previous channel failed: no channels loaded")
            return
        }
        let prevIndex = currentChannelIndex
        let prevChannel = currentChannel?.name ?? "?"
        currentChannelIndex = (currentChannelIndex - 1 + channels.count) % channels.count
        currentRouteIndex = 0
        let newChannel = currentChannel?.name ?? "?"
        logInfo("Previous channel: index: \(prevIndex)→\(currentChannelIndex) channel: '\(prevChannel)' → '\(newChannel)'")
    }

    func nextChannel() {
        guard !channels.isEmpty else {
            logWarning("Next channel failed: no channels loaded")
            return
        }
        let prevIndex = currentChannelIndex
        let prevChannel = currentChannel?.name ?? "?"
        currentChannelIndex = (currentChannelIndex + 1) % channels.count
        currentRouteIndex = 0
        let newChannel = currentChannel?.name ?? "?"
        logInfo("Next channel: index: \(prevIndex)→\(currentChannelIndex) channel: '\(prevChannel)' → '\(newChannel)'")
    }
}
