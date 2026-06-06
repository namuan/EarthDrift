import Foundation

private enum StorageKeys {
    static let lastChannelIndex = "lastChannelIndex"
    static let lastRouteIndex = "lastRouteIndex"
}

@MainActor
@Observable
final class ChannelScheduler {
    var channels: [Channel] = [] {
        didSet {
            logInfo("Channels loaded: count=\(channels.count) names=[\(channels.map { "'\($0.name)'(\($0.routes.count) routes)" }.joined(separator: ", "))]")
        }
    }

    var currentChannelIndex: Int = 0 {
        didSet {
            UserDefaults.standard.set(currentChannelIndex, forKey: StorageKeys.lastChannelIndex)
        }
    }
    var currentRouteIndex: Int = 0 {
        didSet {
            UserDefaults.standard.set(currentRouteIndex, forKey: StorageKeys.lastRouteIndex)
        }
    }

    func restoreLastSession() {
        guard !channels.isEmpty else { return }

        let savedChannelIndex = UserDefaults.standard.integer(forKey: StorageKeys.lastChannelIndex)
        let savedRouteIndex = UserDefaults.standard.integer(forKey: StorageKeys.lastRouteIndex)

        let clampedChannelIndex = max(0, min(savedChannelIndex, channels.count - 1))
        currentChannelIndex = clampedChannelIndex

        guard let channel = currentChannel, !channel.routes.isEmpty else { return }
        currentRouteIndex = max(0, min(savedRouteIndex, channel.routes.count - 1))
    }

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

    func selectChannelAndRoute(channelIndex: Int, routeIndex: Int) {
        guard channelIndex >= 0, channelIndex < channels.count else {
            logWarning("Channel+route select out of bounds: channelIndex=\(channelIndex) count=\(channels.count)")
            return
        }
        let channel = channels[channelIndex]
        guard routeIndex >= 0, routeIndex < channel.routes.count else {
            logWarning("Channel+route select out of bounds: routeIndex=\(routeIndex) count=\(channel.routes.count)")
            return
        }
        let prevChannel = currentChannel?.name ?? "none"
        let prevRoute = currentRoute?.title ?? "none"
        currentChannelIndex = channelIndex
        currentRouteIndex = routeIndex
        let newChannel = currentChannel?.name ?? "?"
        let newRoute = currentRoute?.title ?? "?"
        logInfo("Channel+route selected: '\(prevChannel)' → '\(newChannel)' route: '\(prevRoute)' → '\(newRoute)'")
    }

    func selectChannel(id: UUID) {
        guard let index = channels.firstIndex(where: { $0.id == id }) else {
            logWarning("Channel select by ID failed: id=\(id) not found")
            return
        }
        selectChannel(index: index)
    }

    func selectRoute(index: Int) {
        guard let channel = currentChannel, index >= 0, index < channel.routes.count else {
            logWarning("Route select out of bounds: index=\(index)")
            return
        }
        let prevRoute = currentRoute?.title ?? "?"
        currentRouteIndex = index
        let newRoute = currentRoute?.title ?? "?"
        logInfo("Route selected: channel='\(channel.name)' routeIndex: \(index) route: '\(prevRoute)' → '\(newRoute)'")
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
