# 冷知識圖鑑

一個用 SwiftUI 寫的 iOS 冷知識收藏 App，以圖鑑的形式整理各種有趣的小知識。

## 功能

- **今日一則**：每天固定推薦一則冷知識，同一天內不會改變
- **分類瀏覽**：依「心理認知、社會經濟、哲學思想、數學機率、物理生科、其他」篩選
- **圖鑑編號**：每則知識都有 `No.001` 格式的編號
- **詳細內容**：點進去可以看完整說明，並附上維基百科延伸閱讀連結
- **新增冷知識**：可以自行新增標題、內容與分類
- 內建 120 則冷知識，支援淺色 / 深色模式

## 專案結構

```
ioshw3/
├── MyApp.swift              # App 進入點
├── ContentView.swift        # 根視圖，注入 TriviaStore
├── Models/
│   ├── TriviaFact.swift     # 冷知識資料模型與分類
│   ├── TriviaSeedData.swift # 內建資料
│   └── TriviaStore.swift    # @Observable 資料存放與邏輯
├── Views/
│   ├── AboutView.swift      # 主列表、今日一則、分類篩選
│   ├── FactDetailView.swift # 詳細頁
│   ├── AddTriviaView.swift  # 新增表單
│   └── Theme.swift          # 顏色與字型主題
└── Fonts/
    └── NotoSerifTC-VariableFont.ttf
```

## 技術

- SwiftUI、`NavigationStack`
- Observation（`@Observable`、`.environment`）
- 自訂字型 Noto Serif TC

## 執行環境

- Xcode 27 以上
- iOS 27.0 以上

用 Xcode 開啟 `ioshw3.xcodeproj`，選擇模擬器後執行即可。
