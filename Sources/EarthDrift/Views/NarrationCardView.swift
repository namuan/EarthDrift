import SwiftUI

struct NarrationCardView: View {
    let label: String

    var body: some View {
        HStack {
            Text(label)
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundStyle(.white.opacity(0.6))
                .lineLimit(2)
            Spacer()
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial.opacity(0.5), in: RoundedRectangle(cornerRadius: 8))
    }
}
