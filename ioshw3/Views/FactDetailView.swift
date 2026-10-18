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

                HStack(spacing: 6) {
                    Image(systemName: "book.closed")
                        .foregroundStyle(Theme.accent)
                    Text(readMoreLink)
                        .tint(Theme.accent)
                }
                .font(.subheadline)
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

    /// The "further reading" link, built from a Markdown string because the URL is dynamic.
    /// The destination is wrapped in `< >` so titles with parentheses don't break the link syntax.
    private var readMoreLink: AttributedString {
        let markdown = "[延伸閱讀：維基百科 →](<\(fact.searchURL.absoluteString)>)"
        return (try? AttributedString(markdown: markdown)) ?? AttributedString("延伸閱讀：維基百科 →")
    }
}

#Preview {
    NavigationStack {
        FactDetailView(fact: TriviaStore().facts[0])
    }
}
