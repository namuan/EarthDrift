import SwiftUI

struct ContentView: View {
    @State private var engine = PlaybackEngine()
    @State private var scheduler = ChannelScheduler()
    @State private var showingBrowser = false
    @State private var showingArtMode = false

    var body: some View {
        let _ = logDebug("ContentView body re-evaluated")
        ZStack {
            MapPlayerView(camera: engine.cameraController.camera, controller: engine.cameraController)

            NarrationCardView(point: engine.activeNarration)

            if !showingArtMode {
                VStack {
                    HStack {
                        EarthInsetView(coordinate: engine.cameraController.currentCoordinate)
                            .frame(width: 150, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white.opacity(0.15), lineWidth: 1)
                            )
                            .padding(.leading, 16)
                            .padding(.top, 16)
                        Spacer()
                    }
                    Spacer()
                }
                .allowsHitTesting(false)

                ControlsOverlay(
                    engine: engine,
                    scheduler: scheduler,
                    onShowBrowser: { showingBrowser = true }
                )
                .transition(.opacity)
            }
        }
        .onAppear {
            logInfo("ContentView appeared: loading default channels")
            scheduler.channels = RouteData.defaultChannels
            scheduler.restoreLastSession()
            startCurrentRoute()
        }
        .onChange(of: scheduler.currentChannelIndex) { _, _ in
            startCurrentRoute()
        }
        .onChange(of: engine.routeCompletionCount) { _, _ in
            logDebug("Route completion count changed: \(engine.routeCompletionCount)")
            scheduler.advanceToNextRoute()
            startCurrentRoute()
        }
        .sheet(isPresented: $showingBrowser) {
            logInfo("Channel browser opened: currentChannel='\(scheduler.currentChannel?.name ?? "none")'")
        } content: {
            ChannelBrowser(
                channels: scheduler.channels,
                currentIndex: scheduler.currentChannelIndex,
                onSelect: { index in
                    logInfo("Channel browser: user selected index=\(index)")
                    scheduler.selectChannel(index: index)
                }
            )
        }
        .onTapGesture(count: 2) {
            withAnimation {
                showingArtMode.toggle()
                logInfo("Art mode toggled: \(showingArtMode ? "enabled" : "disabled")")
            }
        }
    }

    private func startCurrentRoute() {
        guard let route = scheduler.currentRoute,
              let channel = scheduler.currentChannel else {
            logWarning("Cannot start route: no current route or channel (channel=\(scheduler.currentChannel?.name ?? "nil") route=\(scheduler.currentRoute?.title ?? "nil"))")
            return
        }
        logInfo("ContentView starting route: '\(route.title)' from channel='\(channel.name)'")
        engine.startPlayback(route: route, channel: channel)
    }
}
