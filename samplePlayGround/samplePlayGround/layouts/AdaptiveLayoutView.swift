import SwiftUI

struct AdaptiveLayoutView: View {
    // 現在の環境を検知する
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        // 水平サイズクラスに基づいてレイアウトを分ける
        // iPadは通常 .regular、iPhoneは縦向きで .compact
        if horizontalSizeClass == .compact {
            phoneLayout
        } else {
            padLayout
        }
    }
    
    // iPhone用レイアウト
    private var phoneLayout: some View {
        VStack {
            headerView
            
            // iPhone向けには縦に積み上げるリスト表示
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(1...10, id: \.self) { index in
                        contentCard(index: index)
                    }
                }
                .padding()
            }
        }
    }
    
    // iPad用レイアウト
    private var padLayout: some View {
        VStack {
            headerView
            
            // iPad向けには横に2列のグリッドレイアウト
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(1...10, id: \.self) { index in
                        contentCard(index: index)
                    }
                }
                .padding()
            }
        }
    }
    
    // 共通ヘッダービュー
    private var headerView: some View {
        VStack(spacing: 8) {
            Text("アダプティブレイアウト")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // デバイスタイプに応じたメッセージ表示
            Text(horizontalSizeClass == .compact ? "iPhoneビュー" : "iPadビュー")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.1))
    }
    
    // コンテンツカード（共通）
    private func contentCard(index: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // カード画像部分（iPadではより大きく表示）
            Rectangle()
                .fill(Color.blue.opacity(0.3))
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Text("\(index)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            // テキストコンテンツ
            VStack(alignment: .leading, spacing: 8) {
                Text("項目 \(index)")
                    .font(.headline)
                
                Text("これはサンプルコンテンツです。デバイスによって表示が変わります。iPadではより洗練されたレイアウトになります。")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(horizontalSizeClass == .compact ? 2 : nil)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// 向きを変えても適応できるようにViewModifierを追加
struct DeviceRotationViewModifier: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action()
            }
    }
}

// ViewModifierを簡単に使うための拡張
extension View {
    func onRotate(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

// さらに高度な例: マスター・ディテールレイアウト
struct MasterDetailView: View {
    @State private var selectedItem: Int? = nil
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            // iPhoneではナビゲーションスタック
            NavigationView {
                List(1...20, id: \.self) { item in
                    NavigationLink(
                        destination: DetailView(item: item),
                        label: {
                            Text("項目 \(item)")
                        }
                    )
                }
                .navigationTitle("マスタービュー")
            }
        } else {
            // iPadでは横に並べたレイアウト
            HStack(spacing: 0) {
                // マスター部分（サイドバー）
                List(1...20, id: \.self) { item in
                    Text("項目 \(item)")
                        .padding()
                        .background(selectedItem == item ? Color.blue.opacity(0.1) : Color.clear)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedItem = item
                        }
                }
                .frame(width: 250)
                .navigationTitle("マスタービュー")
                
                // 区切り線
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 1)
                
                // ディテール部分
                if let selectedItem = selectedItem {
                    DetailView(item: selectedItem)
                        .frame(maxWidth: .infinity)
                } else {
                    // 何も選択されていない時
                    VStack {
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                        Text("項目を選択してください")
                            .font(.headline)
                            .padding(.top)
                    }
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                }
            }
            .onAppear {
                // 初期選択
                if selectedItem == nil {
                    selectedItem = 1
                }
            }
        }
    }
}

// 詳細ビュー
struct DetailView: View {
    let item: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 100, height: 100)
                .overlay(
                    Text("\(item)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                )
            
            Text("項目 \(item) の詳細")
                .font(.title)
            
            Text("これは項目 \(item) の詳細情報です。このビューはiPadでは横に表示され、iPhoneではナビゲーションスタックの次の画面として表示されます。")
                .padding()
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
        .navigationTitle("詳細: 項目 \(item)")
    }
}

// プレビュー
struct AdaptiveLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // iPhone 14 Pro プレビュー
            AdaptiveLayoutView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
                .previewDisplayName("iPhone 14 Pro")
            
            // iPad Pro 12.9インチ プレビュー
            AdaptiveLayoutView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
                .previewDisplayName("iPad Pro 12.9")
            
            // マスターディテールレイアウトのプレビュー
            MasterDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
                .previewDisplayName("Master-Detail iPad")
            
            MasterDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
                .previewDisplayName("Master-Detail iPhone")
        }
    }
}