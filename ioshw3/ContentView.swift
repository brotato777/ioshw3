import SwiftUI

struct ContentView: View {
    @State private var store = TriviaStore()

    var body: some View {
        NavigationStack {
            AboutView()
        }
        .environment(store)
        .tint(Theme.accent)
    }
}

#Preview("Light Mode") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}
