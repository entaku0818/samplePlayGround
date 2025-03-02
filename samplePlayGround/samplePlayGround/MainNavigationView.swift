//
//  MainNavigationView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 2025/03/02.
//


// MainNavigationView.swift
import SwiftUI

struct MainNavigationView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("アニメーションとグラフィックス")) {
                    NavigationLink("Lottieアニメーション", destination: ContentView())
                    NavigationLink("カルーセルビュー", destination: CarouselHomeView())
                }
                
                Section(header: Text("レイアウトとビュー")) {
                    NavigationLink("無限スクロール", destination: CollectionHomeView())
                    NavigationLink("ハーフモーダル", destination: HalfModalView())
                    NavigationLink("複雑なカードビュー", destination: ComplexCardView1())
                    NavigationLink("入れ子スタックビュー", destination: StackView())
                    NavigationLink("過剰なモディファイア", destination: ExcessiveModifiersView())
                    NavigationLink("アニメーション付きモディファイア", destination: ExcessiveModifiers1View())
                    NavigationLink("複雑なアニメーション", destination: ExcessiveModifiers2View())
                }
                
                Section(header: Text("ユーザー入力")) {
                    NavigationLink("テキストフィールド", destination: TextFieldView())
                }
                
                Section(header: Text("メディア")) {
                    NavigationLink("音声録音と再生", destination: AudioRecorderPlayerApp())
                }
                
                Section(header: Text("位置情報")) {
                    NavigationLink("位置情報サービス", destination: MapView())
                }
            }
            .navigationTitle("UI実装サンプル集")
            .listStyle(InsetGroupedListStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainNavigationView()
    }
}