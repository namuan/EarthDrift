import SwiftUI

struct ControlsOverlay: View {
    @Bindable var engine: PlaybackEngine
    @Bindable var scheduler: ChannelScheduler
    var onShowBrowser: () -> Void

    @State private var isVisible = true
    @State private var fadeTask: Task<Void, Never>?
    @State private var isMaximized = false
    @State private var showSettings = false
    @State private var alwaysOnTop = AppDelegate.isAlwaysOnTop

    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack(spacing: 6) {
                    tappableView(systemName: "dice.fill", size: 13, action: { engine.feelingLucky() })
                    tappableView(systemName: "gearshape.fill", size: 13,
                        active: showSettings,
                        action: { withAnimation(.easeInOut(duration: 0.2)) { showSettings.toggle() } })
                    tappableView(systemName: isMaximized
                        ? "arrow.down.right.and.arrow.up.left"
                        : "arrow.up.left.and.arrow.down.right", size: 13,
                        action: { isMaximized.toggle(); AppDelegate.toggleMaximize() })
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(Capsule().fill(.regularMaterial).shadow(color: .black.opacity(0.4), radius: 4, y: 2))
            }
            .padding(.trailing, 10)
            .padding(.top, 10)

            Spacer()

            HStack {
                tappableIcon(icon: "backward.fill", size: 20, action: { scheduler.previousChannel() })
                Spacer()
                tappableIcon(icon: engine.isPlaying ? "pause.fill" : "play.fill", size: 28, large: true,
                    action: { engine.togglePlayPause() })
                Spacer()
                tappableIcon(icon: "forward.fill", size: 20, action: { scheduler.nextChannel() })
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 40)

            HStack {
                tappableChannel(action: { onShowBrowser() })
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

    private func tappableView(systemName: String, size: CGFloat, active: Bool = false, action: @escaping () -> Void) -> some View {
        Image(systemName: systemName)
            .font(.system(size: size))
            .foregroundStyle(active ? .white : .white.opacity(0.7))
            .frame(width: 28, height: 28)
            .background(Circle().fill(active ? .white.opacity(0.25) : .white.opacity(0.15)).shadow(color: .black.opacity(0.4), radius: 3, y: 1))
            .contentShape(Rectangle())
            .onTapGesture { action() }
    }

    private func tappableIcon(icon: String, size: CGFloat, large: Bool = false, action: @escaping () -> Void) -> some View {
        let baseSize: CGFloat = large ? 56 : 44
        return Image(systemName: icon)
            .font(.system(size: size))
            .foregroundStyle(.white)
            .frame(width: baseSize, height: baseSize)
            .background(Circle().fill(.white.opacity(large ? 0.2 : 0.15)).shadow(color: .black.opacity(0.4), radius: large ? 4 : 3, y: large ? 2 : 1))
            .contentShape(Rectangle())
            .onTapGesture { action() }
    }

    private func tappableChannel(action: @escaping () -> Void) -> some View {
        HStack(spacing: 6) {
            Image(systemName: "tv")
                .font(.system(size: 14))
            Text("Channels")
                .font(.subheadline)
        }
        .foregroundStyle(.white.opacity(0.8))
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(Capsule().fill(.white.opacity(0.15)).shadow(color: .black.opacity(0.4), radius: 3, y: 1))
        .contentShape(Rectangle())
        .onTapGesture { action() }
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
            Divider()
                .overlay(.white.opacity(0.15))
            alwaysOnTopToggle
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

    private var alwaysOnTopToggle: some View {
        HStack {
            Image(systemName: "pin.fill")
                .font(.system(size: 11))
            Text("Always on Top")
                .font(.caption)
            Spacer()
            Toggle("", isOn: Binding(
                get: { alwaysOnTop },
                set: { value in
                    alwaysOnTop = value
                    AppDelegate.isAlwaysOnTop = value
                }
            ))
            .toggleStyle(.switch)
            .scaleEffect(0.7)
        }
        .foregroundStyle(.white.opacity(0.8))
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
