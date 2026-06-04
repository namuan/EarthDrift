import SwiftUI

struct NarrationCardView: View {
    let point: NarrationPoint?

    var body: some View {
        VStack {
            Spacer()
            if let point {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(point.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                        Text(point.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.7))
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal, 32)
                .padding(.bottom, 120)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.8), value: point?.id)
    }
}
