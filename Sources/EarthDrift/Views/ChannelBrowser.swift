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
            Text("Choose a Channel")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.top, 32)
                .padding(.bottom, 24)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
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
            }

            if let channel = selectedChannel {
                Divider()
                    .overlay(.white.opacity(0.15))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)

                Text(channel.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 12)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 6) {
                        ForEach(Array(channel.routes.enumerated()), id: \.element.id) { index, route in
                            RouteRow(
                                route: route,
                                isCurrent: selectedChannelIndex == currentChannelIndex && index == currentRouteIndex,
                                number: index + 1
                            )
                            .onTapGesture {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    selectedChannelIndex = selectedChannelIndex
                                }
                                onSelect(selectedChannelIndex, index)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    dismiss()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 32)
                }
            }

            Spacer(minLength: 0)
        }
        .frame(minWidth: 440, idealHeight: 500)
        .background(.black.opacity(0.6))
    }

    private var selectedChannel: Channel? {
        guard channels.indices.contains(selectedChannelIndex) else { return nil }
        return channels[selectedChannelIndex]
    }
}

struct RouteRow: View {
    let route: Route
    let isCurrent: Bool
    let number: Int

    var body: some View {
        HStack(spacing: 14) {
            Text("\(number)")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.4))
                .frame(width: 24, alignment: .leading)

            VStack(alignment: .leading, spacing: 2) {
                Text(route.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(isCurrent ? .white : .white.opacity(0.7))
                Text(route.subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.4))
            }

            Spacer()

            if isCurrent {
                Image(systemName: "play.fill")
                    .font(.system(size: 10))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(Circle().fill(.white.opacity(0.2)))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isCurrent ? .white.opacity(0.1) : .clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isCurrent ? .white.opacity(0.2) : .clear, lineWidth: 1)
        )
        .contentShape(Rectangle())
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isCurrent)
    }
}

struct ChannelCard: View {
    let channel: Channel
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: channel.icon)
                .font(.system(size: 30))
                .foregroundStyle(isSelected ? .white : .white.opacity(0.6))
                .frame(width: 64, height: 64)
                .background(
                    Circle()
                        .fill(isSelected ? .white.opacity(0.2) : .white.opacity(0.08))
                )
                .scaleEffect(isSelected ? 1.1 : 1.0)

            Text(channel.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(isSelected ? .white : .white.opacity(0.5))

            Text("\(channel.routes.count) journeys")
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.4))
        }
        .frame(width: 120)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isSelected ? .white.opacity(0.12) : .clear)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isSelected ? .white.opacity(0.3) : .white.opacity(0.1), lineWidth: 1)
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isSelected)
    }
}
