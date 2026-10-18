import SwiftUI

/// The catalogue home: today's entry on top, a text-only category index,
/// then a table-of-contents style list separated by hairlines.
struct AboutView: View {
    @Environment(TriviaStore.self) private var store
    @State private var selectedCategory: TriviaFact.Category?
    @State private var showingAddSheet = false

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                if let today = store.fact() {
                    todaySection(today)
                }
                categoryTabs
                ForEach(store.facts(in: selectedCategory)) { fact in
                    NavigationLink(value: fact) {
                        FactRow(fact: fact)
                    }
                    .buttonStyle(.plain)
                }
                Text("— 共 \(store.facts.count) 則 —")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
            }
            .padding(.horizontal, 24)
        }
        .background(Theme.paper)
        .foregroundStyle(Theme.ink)
        .navigationDestination(for: TriviaFact.self) { fact in
            FactDetailView(fact: fact)
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("冷知識圖鑑")
                    .font(Theme.serif(17, relativeTo: .headline).weight(.semibold))
            }
            ToolbarItem(placement: .primaryAction) {
                Button("新增", systemImage: "plus") {
                    showingAddSheet = true
                }
                .tint(Theme.ink)
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .sheet(isPresented: $showingAddSheet) {
            AddTriviaView()
        }
    }

    private func todaySection(_ fact: TriviaFact) -> some View {
        NavigationLink(value: fact) {
            VStack(alignment: .leading, spacing: 10) {
                Text("今日一則 · \(Date.now.formatted(.dateTime.month().day().locale(Locale(identifier: "zh_Hant_TW"))))")
                    .font(.footnote)
                    .foregroundStyle(Theme.accent)
                Text(fact.title)
                    .font(Theme.serif(28, relativeTo: .title).weight(.bold))
                Text(fact.firstSentence)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .lineSpacing(6)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 24)
            .padding(.bottom, 32)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var categoryTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                tab("全部", for: nil)
                ForEach(TriviaFact.Category.allCases) { category in
                    tab(category.rawValue, for: category)
                }
            }
        }
        .padding(.bottom, 8)
        .overlay(alignment: .bottom) { Hairline() }
    }

    private func tab(_ title: String, for category: TriviaFact.Category?) -> some View {
        let isSelected = selectedCategory == category
        return Button {
            selectedCategory = category
        } label: {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(isSelected ? AnyShapeStyle(Theme.ink) : AnyShapeStyle(.secondary))
                .padding(.vertical, 6)
                .overlay(alignment: .bottom) {
                    if isSelected {
                        Rectangle()
                            .fill(Theme.accent)
                            .frame(height: 1.5)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

/// One table-of-contents entry: number and category, title, one-line excerpt.
private struct FactRow: View {
    let fact: TriviaFact

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 16) {
                Text(fact.catalogueNumber)
                    .monospacedDigit()
                Text(fact.category.rawValue)
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            Text(fact.title)
                .font(Theme.serif(20, relativeTo: .title3).weight(.semibold))

            Text(fact.firstSentence)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 18)
        .contentShape(Rectangle())
        .overlay(alignment: .bottom) { Hairline() }
    }
}

/// A thin ink rule used between entries.
struct Hairline: View {
    var body: some View {
        Rectangle()
            .fill(Theme.ink.opacity(0.15))
            .frame(height: 0.5)
    }
}

#Preview("Light Mode") {
    NavigationStack {
        AboutView()
    }
    .environment(TriviaStore())
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NavigationStack {
        AboutView()
    }
    .environment(TriviaStore())
    .preferredColorScheme(.dark)
}
