import SwiftUI


struct AdaptiveLayoutView: View {
    // 水平・垂直方向のサイズクラスを検出
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        VStack(spacing: 0) {
            // デバイス情報とサイズクラスの表示
            deviceInfoHeader

            // 水平・垂直サイズクラスの組み合わせに基づいてレイアウトを分ける
            switch (horizontalSizeClass, verticalSizeClass) {
            case (.compact, .regular):
                // iPhoneの縦向き（標準的なiPhone）
                VStack {
                    Text("iPhone - 縦向き")
                        .font(.headline)
                        .padding()

                    phoneLayout
                }

            case (.compact, .compact):
                // iPhoneの横向き（標準的なiPhone）
                VStack {
                    Text("iPhone - 横向き")
                        .font(.headline)
                        .padding()

                    phoneLayoutLandscape
                }

            case (.regular, .compact):
                // iPadの横向きまたはiPhone Maxの横向き
                VStack {
                    Text("iPad - 横向き / iPhone Plus/Max - 横向き")
                        .font(.headline)
                        .padding()

                    padLayoutLandscape
                }

            case (.regular, .regular):
                // iPadの縦向き
                VStack {
                    Text("iPad - 縦向き")
                        .font(.headline)
                        .padding()

                    padLayout
                }

            default:
                // 想定外の組み合わせ（基本的には発生しない）
                Text("不明なサイズクラスの組み合わせです")
                    .font(.headline)
                    .padding()
            }
        }
    }

    // デバイス情報ヘッダー
    private var deviceInfoHeader: some View {
        VStack(spacing: 4) {
            Text("アダプティブレイアウト")
                .font(.largeTitle)
                .fontWeight(.bold)

            // 現在のデバイスタイプとサイズクラスを表示
            Text("水平サイズクラス: \(horizontalSizeClass == .compact ? "compact" : "regular")")
                .font(.subheadline)

            Text("垂直サイズクラス: \(verticalSizeClass == .compact ? "compact" : "regular")")
                .font(.subheadline)

            Text("デバイスタイプ: \(UIDevice.current.userInterfaceIdiom == .pad ? "iPad" : "iPhone")")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.1))
    }

    // iPhone縦向きレイアウト - 1列
    private var phoneLayout: some View {
        ScrollView {
            VStack(spacing: 16) {
                explanationText

                ForEach(1...6, id: \.self) { index in
                    contentCard(index: index)
                }
            }
            .padding()
        }
    }

    // iPhone横向きレイアウト - 2列
    private var phoneLayoutLandscape: some View {
        ScrollView {
            VStack(spacing: 16) {
                explanationText

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(1...6, id: \.self) { index in
                        contentCard(index: index)
                    }
                }
            }
            .padding()
        }
    }

    // iPad縦向きレイアウト - 2列
    private var padLayout: some View {
        ScrollView {
            VStack(spacing: 16) {
                explanationText

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(1...6, id: \.self) { index in
                        contentCard(index: index)
                    }
                }
            }
            .padding()
        }
    }

    // iPad横向きレイアウト - 3列
    private var padLayoutLandscape: some View {
        ScrollView {
            VStack(spacing: 16) {
                explanationText

                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(1...6, id: \.self) { index in
                        contentCard(index: index)
                    }
                }
            }
            .padding()
        }
    }

    // 説明テキスト
    private var explanationText: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("サイズクラスに基づくレイアウト")
                .font(.headline)

            Text("このサンプルでは水平・垂直両方のサイズクラスを組み合わせて、4種類のレイアウトを切り替えています。アプリを回転させると自動的にレイアウトが変わります。")
                .font(.body)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }

    // コンテンツカード
    private func contentCard(index: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // カード画像部分
            ZStack {
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .aspectRatio(horizontalSizeClass == .compact ? 2 : 1.5, contentMode: .fit)

                Text("\(index)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }

            // テキストコンテンツ
            VStack(alignment: .leading, spacing: 8) {
                Text("項目 \(index)")
                    .font(.headline)

                Text("サイズクラスに応じたレイアウト例です。端末を回転させると表示が変わります。iPad向けとiPhone向けで異なるレイアウトを提供しています。")
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
        }
    }
}
