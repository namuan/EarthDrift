import SwiftUI

struct ChannelBrowser: View {
    let channels: [Channel]
    let currentChannelIndex: Int
    let currentRouteIndex: Int
    var onSelect: (Int, Int) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var selectedChannelIndex: Int

    init(channels: [Channel], currentChannelIndex: Int, currentRouteIndex: Int, onSelect: @escaping (Int, Int) -> Void) {
        self.channels = channels
        self.currentChannelIndex = currentChannelIndex
        self.currentRouteIndex = currentRouteIndex
        self.onSelect = onSelect
        self._selectedChannelIndex = State(initialValue: currentChannelIndex)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Text("Choose a Channel")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.bottom, 32)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(channels.enumerated()), id: \.element.id) { index, channel in
                        ChannelCard(
                            channel: channel,
                            isSelected: index == selectedChannelIndex
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                selectedChannelIndex = index
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 8)
            }

            let channel = channels[selectedChannelIndex]
            routeList(for: channel)

            Spacer()
        }
        .background(.black.opacity(0.6))
    }

    private func routeList(for channel: Channel) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(channel.name)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white.opacity(0.6))
                .padding(.horizontal, 40)
                .padding(.top, 24)
                .padding(.bottom, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Array(channel.routes.enumerated()), id: \.element.id) { index, route in
                        RouteCard(
                            route: route,
                            isCurrentRoute: selectedChannelIndex == currentChannelIndex && index == currentRouteIndex
                        )
                        .onTapGesture {
                            onSelect(selectedChannelIndex, index)
                            dismiss()
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 4)
            }
        }
    }
}

struct ChannelCard: View {
    let channel: Channel
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: channel.icon)
                .font(.system(size: 36))
                .foregroundStyle(isSelected ? .white : .white.opacity(0.6))
                .frame(width: 80, height: 80)
                .background(
                    Circle()
                        .fill(isSelected ? .white.opacity(0.2) : .white.opacity(0.08))
                )
                .scaleEffect(isSelected ? 1.1 : 1.0)

            Text(channel.name)
                .font(.headline)
                .foregroundStyle(isSelected ? .white : .white.opacity(0.5))

            Text("\(channel.routes.count) journeys")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.4))
        }
        .frame(width: 140)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(isSelected ? .white.opacity(0.12) : .clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? .white.opacity(0.3) : .white.opacity(0.1), lineWidth: 1)
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected)
    }
}

struct RouteCard: View {
    let route: Route
    let isCurrentRoute: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                if isCurrentRoute {
                    Image(systemName: "play.fill")
                        .font(.caption2)
                        .foregroundStyle(.green)
                }
                Text(route.title)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(isCurrentRoute ? .green : .white)
                    .lineLimit(1)
            }

            Text(route.subtitle)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
                .lineLimit(1)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(width: 200, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isCurrentRoute ? .green.opacity(0.1) : .white.opacity(0.06))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isCurrentRoute ? .green.opacity(0.4) : .white.opacity(0.1), lineWidth: 1)
        )
    }
}

