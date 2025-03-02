import SwiftUI

/// アダプティブレイアウトを示すビュー
/// SwiftUIの`@Environment(\.horizontalSizeClass)`を使用して、デバイスのサイズクラスを検出し、
/// 適切なレイアウトを自動的に表示します
struct AdaptiveLayoutView: View {
    // 水平方向のサイズクラスを検出（iPadでは通常 .regular、iPhoneは縦向きで .compact）
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    // デバイスの方向を追跡するための状態変数
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation

    var body: some View {
        VStack(spacing: 0) {
            // デバイス情報とサイズクラスの表示
            deviceInfoHeader

            // 水平サイズクラスに基づいてレイアウトを分ける
            if horizontalSizeClass == .compact {
                phoneLayout
            } else {
                padLayout
            }
        }
        .onRotate { newOrientation in
            orientation = newOrientation
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

            Text("デバイス向き: \(orientationString)")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.1))
    }

    // 端末の向きを文字列で表現
    private var orientationString: String {
        switch orientation {
        case .portrait: return "縦向き (portrait)"
        case .landscapeLeft, .landscapeRight: return "横向き (landscape)"
        default: return "不明"
        }
    }

    // iPhone用レイアウト：コンテンツを縦に表示
    private var phoneLayout: some View {
        ScrollView {
            VStack(spacing: 16) {
                // 説明テキスト
                explanationText

                // カード一覧を縦に表示
                ForEach(1...6, id: \.self) { index in
                    contentCard(index: index)
                }

                // 安全領域とマージンの図解
                safeAreaDiagram
            }
            .padding()
        }
    }

    // iPad用レイアウト：コンテンツをグリッドで表示
    private var padLayout: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 説明テキスト
                explanationText

                // マスター・ディテールのプレビュー
                masterDetailPreview

                // コンテンツをグリッドで表示
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    verticalSizeClass == .regular ? GridItem(.flexible()) : nil
                ].compactMap { $0 }, spacing: 16) {
                    ForEach(1...6, id: \.self) { index in
                        contentCard(index: index)
                    }
                }

                // 安全領域とマージンの図解
                safeAreaDiagram
            }
            .padding()
        }
    }

    // 説明テキスト
    private var explanationText: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("iOSのアダプティブレイアウト")
                .font(.headline)

            Text("このサンプルでは、SwiftUIの環境値を使ってデバイスのサイズクラスを検出し、適切なレイアウトを自動的に表示しています。iPadでは水平サイズクラスが「regular」となり、コンテンツをグリッドで表示。iPhoneの縦向きでは「compact」となり、コンテンツを縦に積み上げています。")
                .font(.body)

            Text("また、iPhoneを横向きにすると、モデルによって水平サイズクラスが変わります（Plus/Maxモデルは「regular」、それ以外は「compact」）。このような違いを考慮したレイアウト設計が必要です。")
                .font(.body)
                .padding(.top, 8)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }

    // マスター・ディテールのプレビュー（iPadのみ）
    private var masterDetailPreview: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("iPad向けマスター・ディテールレイアウト")
                .font(.headline)

            HStack(spacing: 0) {
                // サイドバー
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(1...5, id: \.self) { i in
                        HStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 24, height: 24)

                            Text("項目 \(i)")
                                .font(.subheadline)

                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(i == 1 ? Color.blue.opacity(0.1) : Color.clear)
                        .cornerRadius(8)
                    }

                    Spacer()
                }
                .frame(width: 200)
                .padding(.vertical)
                .background(Color.gray.opacity(0.05))

                // 区切り線
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 1)

                // ディテール
                VStack(alignment: .leading, spacing: 12) {
                    VStack(spacing: 20) {
                        Circle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 60, height: 60)

                        Text("項目 1 の詳細")
                            .font(.headline)

                        Text("iPadでは横に2ペインを表示し、コンテンツを有効活用できます。iPhoneでは代わりにナビゲーションスタックを使います。")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
            }
            .frame(height: 200)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .padding(.vertical, 8)
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

                Text("デバイスとサイズクラスに応じてレイアウトが変化します。iPadでは複数カラム、iPhoneでは単一カラムで表示されます。")
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

    // 安全領域とマージンの図解
    private var safeAreaDiagram: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("安全領域とマージン")
                .font(.headline)

            ZStack {
                // 画面全体
                Rectangle()
                    .stroke(Color.gray, lineWidth: 2)
                    .background(Color.gray.opacity(0.05))

                // 安全領域
                Rectangle()
                    .stroke(Color.blue, lineWidth: 2)
                    .padding(.top, horizontalSizeClass == .compact ? 47 : 24) // ステータスバー
                    .padding(.bottom, 34) // ホームインジケーター
                    .background(Color.blue.opacity(0.1))

                VStack {
                    // 上部の説明
                    HStack {
                        Spacer()
                        Text("ステータスバー")
                            .font(.caption)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.white)
                            .cornerRadius(4)
                        Spacer()
                    }
                    .padding(.top, 4)

                    Spacer()

                    // 下部の説明
                    HStack {
                        Spacer()
                        Text("ホームインジケーター")
                            .font(.caption)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(Color.white)
                            .cornerRadius(4)
                        Spacer()
                    }
                    .padding(.bottom, 4)
                }

                // 注釈
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: 12, height: 12)
                                Text("安全領域")
                                    .font(.caption)
                            }

                            HStack {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 12, height: 12)
                                Text("画面領域")
                                    .font(.caption)
                            }
                        }
                        .padding(8)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 1)

                        Spacer()
                    }
                    .padding()
                }
            }
            .frame(height: 200)
            .padding(.vertical, 8)
        }
    }
}

// デバイスの回転を検出するViewModifier
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// ViewModifierを簡単に使うための拡張
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

/// マスター・ディテールパターンのサンプル
/// iPadでは横に並べたレイアウト、iPhoneではナビゲーション階層を使用
struct MasterDetailView: View {
    @State private var selectedItem: Int? = 1
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        VStack(spacing: 0) {
            // タイトルと説明
            VStack(spacing: 8) {
                Text("マスター・ディテールパターン")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("水平サイズクラス: \(horizontalSizeClass == .compact ? "compact" : "regular")")
                    .font(.subheadline)

                Text("このパターンはiPadとiPhoneで異なる表示を実現します")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.1))

            // コンテンツ部分: サイズクラスに応じて表示を変更
            if horizontalSizeClass == .compact {
                // iPhoneではナビゲーションスタック
                NavigationView {
                    List(1...20, id: \.self) { item in
                        NavigationLink(
                            destination: DetailView(item: item),
                            label: {
                                HStack {
                                    Circle()
                                        .fill(Color.blue.opacity(0.2))
                                        .frame(width: 32, height: 32)

                                    Text("項目 \(item)")
                                        .padding(.leading, 8)
                                }
                                .padding(.vertical, 4)
                            }
                        )
                    }
                    .navigationTitle("項目一覧")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .navigationViewStyle(StackNavigationViewStyle())
            } else {
                // iPadでは横に並べたレイアウト
                HStack(spacing: 0) {
                    // マスター部分（サイドバー）
                    List(1...20, id: \.self) { item in
                        HStack {
                            Circle()
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 32, height: 32)

                            Text("項目 \(item)")
                                .padding(.leading, 8)
                        }
                        .padding(.vertical, 4)
                        .contentShape(Rectangle())
                        .background(selectedItem == item ? Color.blue.opacity(0.1) : Color.clear)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedItem = item
                        }
                    }
                    .frame(width: 250)
                    .listStyle(SidebarListStyle())

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
            }
        }
    }
}

/// 詳細ビュー
struct DetailView: View {
    let item: Int

    var body: some View {
        ScrollView {
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

                VStack(alignment: .leading, spacing: 16) {
                    descriptionSection(
                        title: "レイアウトの適応",
                        content: "このビューはiPadでは横に表示され、iPhoneではナビゲーションスタックの次の画面として表示されます。これにより、画面サイズに応じた最適なユーザー体験を提供できます。"
                    )

                    descriptionSection(
                        title: "水平サイズクラス",
                        content: "iOS、iPadOSでは「サイズクラス」という概念で画面サイズを表現します。水平方向は「compact」または「regular」、垂直方向も同様です。iPadは基本的に両方向が「regular」ですが、iPhoneは縦向きでは水平が「compact」、Plus/Maxモデルの横向きでは「regular」になります。"
                    )

                    descriptionSection(
                        title: "安全領域の考慮",
                        content: "コンテンツを配置する際は「安全領域（Safe Area）」を考慮する必要があります。これはノッチやホームインジケーター、ステータスバーなどのシステムUI要素を避ける領域です。SwiftUIではデフォルトで考慮されますが、意識して設計することが重要です。"
                    )

                    descriptionSection(
                        title: "Split Viewへの対応",
                        content: "iPadではSplit Viewを使ってアプリを分割表示できます。このとき、アプリの表示幅が制限され、サイズクラスが変わる可能性があります。例えば、1/3幅の表示では水平サイズクラスが「compact」になります。"
                    )
                }
                .padding()

                Spacer(minLength: 40)
            }
            .padding()
        }
        .navigationTitle("詳細: 項目 \(item)")
    }

    private func descriptionSection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

/// サイズクラス情報を表示するデモビュー
struct SizeClassInfoView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    var body: some View {
        VStack(spacing: 20) {
            Text("iOS サイズクラス")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 16) {
                sizeClassInfo(
                    title: "水平サイズクラス",
                    value: horizontalSizeClass == .compact ? "compact" : "regular",
                    description: "画面の横幅を表します。iPadは基本的にregular、iPhoneは縦向きではcompact、横向きではモデルによって異なります。"
                )

                sizeClassInfo(
                    title: "垂直サイズクラス",
                    value: verticalSizeClass == .compact ? "compact" : "regular",
                    description: "画面の縦幅を表します。iPadとiPhoneの縦向きはregular、横向きではcompactになります。"
                )

                deviceInfo
            }
            .padding()
            .background(Color.blue.opacity(0.05))
            .cornerRadius(12)

            Spacer()

            VStack(spacing: 12) {
                Text("デバイスを回転させて変化を確認してください")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Image(systemName: "rotate.right")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding()
        }
        .padding()
    }

    private func sizeClassInfo(title: String, value: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)

                Spacer()

                Text(value)
                    .font(.headline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(
                        value == "compact" ? Color.orange : Color.green
                    )
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    private var deviceInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("デバイス情報")
                .font(.headline)

            HStack {
                Image(systemName: UIDevice.current.userInterfaceIdiom == .pad ? "ipad" : "iphone")
                    .font(.title2)

                VStack(alignment: .leading, spacing: 4) {
                    Text(UIDevice.current.userInterfaceIdiom == .pad ? "iPad" : "iPhone")
                        .font(.subheadline)

                    Text("向き: \(UIDevice.current.orientation.isPortrait ? "縦向き" : "横向き")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 1)
        }
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

            // サイズクラス情報ビュー
            SizeClassInfoView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
                .previewDisplayName("Size Class Info")
        }
    }
}

           
