import SwiftUI

struct ChannelBrowser: View {
    let channels: [Channel]
    let currentIndex: Int
    var onSelect: (Int) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var selectedIndex: Int

    init(channels: [Channel], currentIndex: Int, onSelect: @escaping (Int) -> Void) {
        self.channels = channels
        self.currentIndex = currentIndex
        self.onSelect = onSelect
        self._selectedIndex = State(initialValue: currentIndex)
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
                            isSelected: index == selectedIndex
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                selectedIndex = index
                            }
                            onSelect(index)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                dismiss()
                            }
                        }
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 8)
            }

            Spacer()
        }
        .background(.black.opacity(0.6))
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
