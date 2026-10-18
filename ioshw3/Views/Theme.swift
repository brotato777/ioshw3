import SwiftUI

/// The whole visual system: paper, ink, one accent (AccentColor), and two typefaces.
enum Theme {
    static let paper = Color("Paper")
    static let ink = Color("Ink")
    /// The app's single accent: a seal-ink vermilion.
    static let accent = Color("AccentColor")

    /// Song-style serif (bundled Noto Serif TC) for titles; body text stays the system sans.
    static func serif(_ size: CGFloat, relativeTo style: Font.TextStyle = .body) -> Font {
        .custom("Noto Serif TC", size: size, relativeTo: style)
    }
}
