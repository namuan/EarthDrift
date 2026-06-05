import SwiftUI

struct ControlsOverlay: View {
    @Bindable var engine: PlaybackEngine
    @Bindable var scheduler: ChannelScheduler
    var onShowBrowser: () -> Void

    @State private var isVisible = true
    @State private var fadeTask: Task<Void, Never>?
    @State private var isMaximized = false
    @State private var showSettings = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { engine.feelingLucky() }) {
                    Image(systemName: "dice.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.6))
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(.white.opacity(0.1)))
                }
                .buttonStyle(.plain)
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showSettings.toggle()
                    }
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 13))
                        .foregroundStyle(showSettings ? .white : .white.opacity(0.6))
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(showSettings ? .white.opacity(0.2) : .white.opacity(0.1)))
                }
                .buttonStyle(.plain)
                Button(action: {
                    isMaximized.toggle()
                    AppDelegate.toggleMaximize()
                }) {
                    Image(systemName: isMaximized
                        ? "arrow.down.right.and.arrow.up.left"
                        : "arrow.up.left.and.arrow.down.right")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.6))
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(.white.opacity(0.1)))
                }
                .buttonStyle(.plain)
            }
            .padding(.trailing, 16)
            .padding(.top, 16)

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
        .overlay {
            if showSettings {
                settingsBackdrop
            }
        }
        .onKeyPress(.escape) {
            if showSettings {
                withAnimation(.easeInOut(duration: 0.2)) { showSettings = false }
                return .handled
            }
            return .ignored
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

    private var settingsBackdrop: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) { showSettings = false }
            }
            .overlay(alignment: .topTrailing) {
                settingsPanel
                    .padding(.top, 52)
                    .padding(.trailing, 16)
                    .onTapGesture { }
            }
    }

    private var settingsPanel: some View {
        VStack(alignment: .leading, spacing: 14) {
            pitchSlider
            speedSlider
            zoomSlider
            Divider()
                .overlay(.white.opacity(0.15))
            luckyDurationSlider
        }
        .padding(16)
        .frame(width: 200)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private var pitchSlider: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "viewfinder")
                    .font(.system(size: 11))
                Text("Pitch")
                    .font(.caption)
                Spacer()
                Text("\(Int(engine.cameraController.pitch))°")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                    .monospacedDigit()
            }
            .foregroundStyle(.white.opacity(0.8))
            Slider(value: $engine.cameraController.pitch, in: 0...90, step: 5)
                .tint(.white.opacity(0.7))
        }
    }

    private var speedSlider: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "hare.fill")
                    .font(.system(size: 11))
                Text("Speed")
                    .font(.caption)
                Spacer()
                Text(String(format: "%.1f×", engine.speedMultiplier))
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                    .monospacedDigit()
            }
            .foregroundStyle(.white.opacity(0.8))
            Slider(value: $engine.speedMultiplier, in: 0.25...4.0, step: 0.25)
                .tint(.white.opacity(0.7))
        }
    }

    private var zoomSlider: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 11))
                Text("Zoom")
                    .font(.caption)
                Spacer()
                Text(String(format: "%.1f×", engine.cameraController.altitudeMultiplier))
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                    .monospacedDigit()
            }
            .foregroundStyle(.white.opacity(0.8))
            Slider(value: $engine.cameraController.altitudeMultiplier, in: 0.25...4.0, step: 0.25)
                .tint(.white.opacity(0.7))
        }
    }

    private var luckyDurationSlider: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "dice.fill")
                    .font(.system(size: 11))
                Text("Lucky")
                    .font(.caption)
                Spacer()
                Text("\(Int(engine.luckyDuration))s")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                    .monospacedDigit()
            }
            .foregroundStyle(.white.opacity(0.8))
            Slider(value: $engine.luckyDuration, in: 10...120, step: 10)
                .tint(.white.opacity(0.7))
        }
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
