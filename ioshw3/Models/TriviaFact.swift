import Foundation

struct TriviaFact: Identifiable, Hashable {
    let id: UUID
    /// Catalogue number shown as "No.017". Assigned by `TriviaStore`.
    var number: Int
    var category: Category
    var title: String
    var detail: String

    init(id: UUID = UUID(), number: Int = 0, category: Category, title: String, detail: String) {
        self.id = id
        self.number = number
        self.category = category
        self.title = title
        self.detail = detail
    }

    var catalogueNumber: String {
        "No." + String(format: "%03d", number)
    }

    /// The opening sentence of the detail, used for the list excerpt and "今日一則".
    var firstSentence: String {
        guard let end = detail.firstIndex(where: { "。！？".contains($0) }) else { return detail }
        return String(detail[...end])
    }

    /// A generic Wikipedia search link built from the fact's title.
    var searchURL: URL {
        let query = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? title
        return URL(string: "https://zh.wikipedia.org/wiki/Special:Search?search=\(query)&go=Go")!
    }
}

extension TriviaFact {
    enum Category: String, CaseIterable, Identifiable, Hashable {
        case psychology = "心理認知"
        case society = "社會經濟"
        case philosophy = "哲學思想"
        case math = "數學機率"
        case science = "物理生科"
        case misc = "其他"

        var id: String { rawValue }
    }
}
