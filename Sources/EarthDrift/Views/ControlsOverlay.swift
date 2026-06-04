import SwiftUI

struct ControlsOverlay: View {
    @Bindable var engine: PlaybackEngine
    @Bindable var scheduler: ChannelScheduler
    var onShowBrowser: () -> Void

    @State private var isVisible = true
    @State private var fadeTask: Task<Void, Never>?

    var body: some View {
        VStack {
            Spacer()

            HStack {
                previousButton
                Spacer()
                playPauseButton
                Spacer()
                nextButton
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 40)

            HStack {
                channelButton
                Spacer()
                if let route = engine.currentRoute {
                    VStack(alignment: .center, spacing: 2) {
                        Text(route.title)
                            .font(.headline)
                            .foregroundStyle(.white)
                        Text(route.subtitle)
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                }
                Spacer()
                liveBadge
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 16)
            .padding(.top, 12)
            .background(.ultraThinMaterial)
        }
        .opacity(isVisible ? 1 : 0)
        .animation(.easeInOut(duration: 0.6), value: isVisible)
        .contentShape(Rectangle())
        .onHover { hovering in
            if hovering {
                showControls()
            } else {
                scheduleFade()
            }
        }
        .onTapGesture {
            showControls()
            scheduleFade()
        }
    }

    private var playPauseButton: some View {
        Button(action: { engine.togglePlayPause() }) {
            Image(systemName: engine.isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(.white.opacity(0.15)))
        }
        .buttonStyle(.plain)
    }

    private var previousButton: some View {
        Button(action: { scheduler.previousChannel() }) {
            Image(systemName: "backward.fill")
                .font(.system(size: 20))
                .foregroundStyle(.white.opacity(0.7))
                .frame(width: 44, height: 44)
                .background(Circle().fill(.white.opacity(0.1)))
        }
        .buttonStyle(.plain)
    }

    private var nextButton: some View {
        Button(action: { scheduler.nextChannel() }) {
            Image(systemName: "forward.fill")
                .font(.system(size: 20))
                .foregroundStyle(.white.opacity(0.7))
                .frame(width: 44, height: 44)
                .background(Circle().fill(.white.opacity(0.1)))
        }
        .buttonStyle(.plain)
    }

    private var channelButton: some View {
        Button(action: { onShowBrowser() }) {
            HStack(spacing: 6) {
                Image(systemName: "tv")
                    .font(.system(size: 14))
                Text("Channels")
                    .font(.subheadline)
            }
            .foregroundStyle(.white.opacity(0.7))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Capsule().fill(.white.opacity(0.1)))
        }
        .buttonStyle(.plain)
    }

    private var liveBadge: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(.red)
                .frame(width: 6, height: 6)
            Text("LIVE")
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundStyle(.white.opacity(0.8))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Capsule().fill(.white.opacity(0.1)))
    }

    private func showControls() {
        fadeTask?.cancel()
        isVisible = true
    }

    private func scheduleFade() {
        fadeTask?.cancel()
        fadeTask = Task {
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 0.6)) {
                isVisible = false
            }
        }
    }
}
