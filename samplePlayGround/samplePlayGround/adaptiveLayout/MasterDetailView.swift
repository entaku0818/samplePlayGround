//
//  MasterDetailView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 2025/03/02.
//


import SwiftUI

/// マスター・ディテールパターンのサンプル
/// iPadでは横に並べたレイアウト、iPhoneではナビゲーション階層を使用
struct MasterDetailView: View {
    @State private var selectedItem: Int? = 1
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var body: some View {
        VStack(spacing: 0) {
            // タイトルと説明
            VStack(spacing: 8) {
                Text("マスター・ディテールパターン")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("水平サイズクラス: \(horizontalSizeClass == .compact ? "compact" : "regular")")
                    .font(.subheadline)
                
                Text("垂直サイズクラス: \(verticalSizeClass == .compact ? "compact" : "regular")")
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

// プレビュー
struct MasterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // iPhone 14 Pro プレビュー
            MasterDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
                .previewDisplayName("MasterDetail iPhone")
            
            // iPad Pro 12.9インチ プレビュー
            MasterDetailView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
                .previewDisplayName("MasterDetail iPad")
        }
    }
}