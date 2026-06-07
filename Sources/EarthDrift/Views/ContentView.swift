import SwiftUI

struct ContentView: View {
    @State private var engine = PlaybackEngine()
    @State private var scheduler = ChannelScheduler()
    @State private var showingBrowser = false
    @State private var showingArtMode = false
    @AppStorage("alwaysOnTop") private var alwaysOnTop = false

    var body: some View {
        ZStack {
            MapPlayerView(controller: engine.cameraController)

            if !showingArtMode {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            EarthInsetView(coordinate: engine.cameraController.currentCoordinate)
                                .frame(width: 150, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(color: .white.opacity(0.25), radius: 10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )

                            NarrationCardView(label: engine.locationLabel)
                                .frame(width: 150)
                        }
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
        .ignoresSafeArea(edges: alwaysOnTop ? .all : [])
        .onAppear {
            logInfo("ContentView appeared: loading default channels")
            scheduler.channels = RouteData.defaultChannels
            scheduler.restoreLastSession()
            startCurrentRoute()
        }
        .onChange(of: scheduler.currentRoute?.id) { _, _ in
            startCurrentRoute()
        }
        .onChange(of: engine.routeCompletionCount) { _, _ in
            if engine.isFeelingLucky {
                engine.feelingLucky()
            } else {
                logDebug("Route completion count changed: \(engine.routeCompletionCount)")
                scheduler.advanceToNextRoute()
                startCurrentRoute()
            }
        }
        .sheet(isPresented: $showingBrowser) {
            logInfo("Channel browser opened: currentChannel='\(scheduler.currentChannel?.name ?? "none")' currentRoute='\(scheduler.currentRoute?.title ?? "none")'")
        } content: {
            ChannelBrowser(
                channels: scheduler.channels,
                currentChannelIndex: scheduler.currentChannelIndex,
                currentRouteIndex: scheduler.currentRouteIndex,
                onSelect: { channelIndex, routeIndex in
                    logInfo("Channel browser: user selected channelIndex=\(channelIndex) routeIndex=\(routeIndex)")
                    scheduler.selectChannelAndRoute(channelIndex: channelIndex, routeIndex: routeIndex)
                }
            )
            .frame(minWidth: 640, idealWidth: 800, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity)
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
