import SwiftUI

/// A full reading page for one entry: large serif title, one meta line,
/// then loosely leaded body text (about 1.7× line height).
struct FactDetailView: View {
    let fact: TriviaFact

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("\(fact.catalogueNumber)　\(fact.category.rawValue)")
                    .font(.footnote)
                    .monospacedDigit()
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 12)

                Text(fact.title)
                    .font(Theme.serif(34, relativeTo: .largeTitle).weight(.bold))
                    .padding(.bottom, 24)

                Hairline()
                    .padding(.bottom, 24)

                Text(fact.detail)
                    .font(.body)
                    .lineSpacing(11)
                    .textSelection(.enabled)
                    .padding(.bottom, 32)

                Link("延伸閱讀：維基百科 →", destination: fact.searchURL)
                    .font(.subheadline)
                    .foregroundStyle(Theme.accent)
            }
            .frame(maxWidth: 600, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 48)
            .frame(maxWidth: .infinity)
        }
        .background(Theme.paper)
        .foregroundStyle(Theme.ink)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        FactDetailView(fact: TriviaStore().facts[0])
    }
}
