import SwiftUI

struct WeatherOverlayView: View {
    let effect: WeatherEffect
    let intensity: Double

    var body: some View {
        if effect == .clear { return AnyView(EmptyView()) }

        return AnyView(
            TimelineView(.animation) { timeline in
                let time = timeline.date.timeIntervalSince1970
                Canvas { context, size in
                    switch effect {
                    case .clear: break
                    case .clouds: drawClouds(context: &context, size: size, time: time)
                    case .fog: drawFog(context: &context, size: size, time: time)
                    case .storm: drawStorm(context: &context, size: size, time: time)
                    }
                }
            }
            .allowsHitTesting(false)
        )
    }

    // MARK: - Clouds

    private func drawClouds(context: inout GraphicsContext, size: CGSize, time: TimeInterval) {
        for cloud in cloudDefs {
            let driftRange: Double = 1.4
            let drift = fmod(time * cloud.driftSpeed, driftRange) - 0.2
            let x = size.width * CGFloat(drift)
            let y = size.height * cloud.y
            let w = size.width * cloud.width
            let h = w * cloud.aspectRatio

            let rect = CGRect(x: x - w / 2, y: y - h / 2, width: w, height: h)
            let center = CGPoint(x: x, y: y)
            let radius = max(w, h) / 2

            context.fill(
                Path(ellipseIn: rect),
                with: .radialGradient(
                    Gradient(colors: [
                        Color.white.opacity(cloud.opacity * intensity),
                        Color.white.opacity(0.0),
                    ]),
                    center: center,
                    startRadius: 0,
                    endRadius: radius
                )
            )
        }
    }

    // MARK: - Fog

    private func drawFog(context: inout GraphicsContext, size: CGSize, time: TimeInterval) {
        let pulse = (sin(time * 0.35) + 1) / 2
        let edgeOpacity = (0.12 + 0.06 * pulse) * intensity

        let minDim = min(size.width, size.height)
        context.fill(
            Path(CGRect(origin: .zero, size: size)),
            with: .radialGradient(
                Gradient(colors: [
                    Color.white.opacity(0.0),
                    Color.white.opacity(edgeOpacity),
                ]),
                center: CGPoint(x: size.width / 2, y: size.height / 2),
                startRadius: minDim * 0.35,
                endRadius: max(size.width, size.height) * 0.65
            )
        )
    }

    // MARK: - Storm

    private func drawStorm(context: inout GraphicsContext, size: CGSize, time: TimeInterval) {
        context.fill(
            Path(CGRect(origin: .zero, size: size)),
            with: .color(Color.black.opacity(0.18 * intensity))
        )

        let rainColor = Color(red: 0.65, green: 0.75, blue: 0.95)
        let rainCount = 80
        let rainPhase = Int(time * 3.5)

        for i in 0..<rainCount {
            let r1 = hash(i * 7919 + rainPhase * 31)
            let r2 = hash(i * 6271 + rainPhase * 37)
            let r3 = hash(i * 3343 + rainPhase * 53)
            let x = CGFloat(r1) * size.width
            let y = CGFloat(r2) * size.height
            let len = CGFloat(r3) * 70 + 20

            var path = Path()
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x - len * 0.35, y: y + len * 0.94))
            context.stroke(
                path,
                with: .color(rainColor.opacity(0.07 * intensity)),
                lineWidth: 1
            )
        }

        let lightningPeriod = 6.5
        let lightningCycle = time.truncatingRemainder(dividingBy: lightningPeriod)

        if lightningCycle < 0.15 {
            let progress = lightningCycle / 0.15
            let brightness: Double
            if progress < 0.3 {
                brightness = progress / 0.3
            } else if progress > 0.7 {
                brightness = (1.0 - progress) / 0.3
            } else {
                brightness = 1.0
            }
            context.fill(
                Path(CGRect(origin: .zero, size: size)),
                with: .color(Color.white.opacity(0.55 * brightness * intensity))
            )
        }
    }

    // MARK: - Helpers

    private func hash(_ seed: Int) -> Double {
        let x = Int64(seed)
        let h = (x &* 6_364_136_223_846_793_005) &+ 1_442_695_040_888_963_407
        let bits = Int(truncatingIfNeeded: h & 0x7FFF_FFFF)
        return Double(bits) / Double(0x7FFF_FFFF)
    }

    // MARK: - Cloud definitions

    private struct CloudDef {
        var y: Double
        var width: Double
        var aspectRatio: Double
        var driftSpeed: Double
        var opacity: Double
    }

    private let cloudDefs: [CloudDef] = [
        CloudDef(y: 0.12, width: 0.35, aspectRatio: 0.25, driftSpeed: 0.08, opacity: 0.38),
        CloudDef(y: 0.28, width: 0.22, aspectRatio: 0.32, driftSpeed: 0.05, opacity: 0.32),
        CloudDef(y: 0.42, width: 0.40, aspectRatio: 0.22, driftSpeed: 0.09, opacity: 0.35),
        CloudDef(y: 0.58, width: 0.28, aspectRatio: 0.28, driftSpeed: 0.07, opacity: 0.40),
        CloudDef(y: 0.75, width: 0.36, aspectRatio: 0.24, driftSpeed: 0.08, opacity: 0.33),
        CloudDef(y: 0.90, width: 0.26, aspectRatio: 0.30, driftSpeed: 0.06, opacity: 0.36),
        CloudDef(y: 0.06, width: 0.20, aspectRatio: 0.35, driftSpeed: 0.04, opacity: 0.28),
        CloudDef(y: 0.50, width: 0.32, aspectRatio: 0.20, driftSpeed: 0.07, opacity: 0.34),
        CloudDef(y: 0.20, width: 0.18, aspectRatio: 0.38, driftSpeed: 0.04, opacity: 0.30),
        CloudDef(y: 0.65, width: 0.42, aspectRatio: 0.23, driftSpeed: 0.10, opacity: 0.37),
        CloudDef(y: 0.35, width: 0.20, aspectRatio: 0.33, driftSpeed: 0.05, opacity: 0.31),
        CloudDef(y: 0.82, width: 0.30, aspectRatio: 0.26, driftSpeed: 0.09, opacity: 0.35),
    ]
}
