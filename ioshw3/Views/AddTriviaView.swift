import SwiftUI

struct AddTriviaView: View {
    @Environment(TriviaStore.self) private var store
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var detail = ""
    @State private var category: TriviaFact.Category = .science

    private var canSave: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !detail.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("分類") {
                    Picker("選擇分類", selection: $category) {
                        ForEach(TriviaFact.Category.allCases) { cat in
                            Text(cat.rawValue)
                                .tag(cat)
                        }
                    }
                }

                Section("標題") {
                    TextField("例如：章魚有三顆心臟", text: $title)
                }

                Section("內容") {
                    TextEditor(text: $detail)
                        .frame(minHeight: 120)
                        .lineSpacing(6)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Theme.paper)
            .navigationTitle("新增冷知識")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("儲存") {
                        store.addFact(category: category, title: title, detail: detail)
                        dismiss()
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
}

#Preview {
    AddTriviaView()
        .environment(TriviaStore())
}
