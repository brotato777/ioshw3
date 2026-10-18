import Foundation
import Observation

@Observable
final class TriviaStore {
    var facts: [TriviaFact]

    init(facts: [TriviaFact] = TriviaFact.seedFacts) {
        // Number entries in catalogue order, starting from No.001.
        self.facts = facts.enumerated().map { index, fact in
            var fact = fact
            fact.number = index + 1
            return fact
        }
    }

    func addFact(category: TriviaFact.Category, title: String, detail: String) {
        let next = (facts.map(\.number).max() ?? 0) + 1
        facts.append(TriviaFact(number: next, category: category, title: title, detail: detail))
    }

    func facts(in category: TriviaFact.Category?) -> [TriviaFact] {
        guard let category else { return facts }
        return facts.filter { $0.category == category }
    }

    /// One entry per calendar day, stable for the whole day.
    func fact(for date: Date = .now) -> TriviaFact? {
        guard !facts.isEmpty else { return nil }
        let day = Calendar.current.ordinality(of: .day, in: .era, for: date) ?? 0
        return facts[day % facts.count]
    }
}
