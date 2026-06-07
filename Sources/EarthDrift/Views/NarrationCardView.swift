import SwiftUI

struct NarrationCardView: View {
    let point: NarrationPoint?

    var body: some View {
        if let point {
            HStack {
                VStack(alignment: .leading, spacing: 1) {
                    Text("Now passing")
                        .font(.caption2)
                        .fontWeight(.regular)
                        .foregroundStyle(.white.opacity(0.35))
                    Text(point.title)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(.white.opacity(0.8))
                }
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial.opacity(0.5), in: RoundedRectangle(cornerRadius: 8))
            .transition(.opacity)
        }
    }
}
