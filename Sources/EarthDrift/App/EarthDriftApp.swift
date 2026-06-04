import SwiftUI

@main
struct EarthDriftApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentMinSize)
        .defaultSize(width: 1200, height: 800)
    }
}

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private static var preMaximizeFrame: NSRect?

    static func toggleMaximize() {
        guard let window = NSApplication.shared.windows.first else { return }
        guard let screen = window.screen ?? NSScreen.main else { return }

        if preMaximizeFrame != nil {
            window.setFrame(preMaximizeFrame!, display: true, animate: true)
            preMaximizeFrame = nil
        } else {
            preMaximizeFrame = window.frame
            window.setFrame(screen.visibleFrame, display: true, animate: true)
        }
    }

    static var isMaximized: Bool { preMaximizeFrame != nil }

    func applicationDidFinishLaunching(_ notification: Notification) {
        logInfo("Earth Drift launched: bundle=\(Bundle.main.bundleIdentifier ?? "?") version=\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?") build=\(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "?")")
        logInfo("Log directory: \(RollingFileLogger.shared.logDirectoryPath)")

        if let window = NSApplication.shared.windows.first {
            window.titlebarAppearsTransparent = true
            window.isMovableByWindowBackground = true
            window.collectionBehavior = [.fullScreenPrimary]
            logDebug("Window configured: titlebarAppearsTransparent movementByBackground fullScreenPrimary")
        } else {
            logWarning("No window found at launch")
        }
    }

    func applicationWillTerminate(_ notification: Notification) {
        logInfo("Earth Drift terminating")
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
