import SwiftUI

/// A vermilion name seal, as if stamped onto the page.
/// The image comes from the `Seal` asset, which has separate Light / Dark variants.
struct SealView: View {
    /// Edge length of the square seal, in points.
    var size: CGFloat = 64
    /// Tilt in degrees; a slight angle makes it look hand-stamped.
    var rotation: Double = -8
    /// Overall ink strength.
    var inkOpacity: Double = 0.9

    var body: some View {
        ZStack {
            // Bottom layer: a faint, slightly offset second impression,
            // like ink bleeding when a seal is pressed twice.
            Image("Seal")
                .resizable()
                .scaledToFit()
                .offset(x: 0.8, y: 1)
                .opacity(0.25)

            // Top layer: the main impression.
            Image("Seal")
                .resizable()
                .scaledToFit()
        }
        .frame(width: size, height: size)
        .rotationEffect(.degrees(rotation))
        .opacity(inkOpacity)
        .accessibilityLabel("冷知識印章")
    }
}

#Preview("Light Mode") {
    HStack(spacing: 32) {
        SealView()
        SealView(size: 96, rotation: 6)
    }
    .padding(40)
    .background(Theme.paper)
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    HStack(spacing: 32) {
        SealView()
        SealView(size: 96, rotation: 6)
    }
    .padding(40)
    .background(Theme.paper)
    .preferredColorScheme(.dark)
}
