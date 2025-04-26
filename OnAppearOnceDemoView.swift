import SwiftUI

struct OnAppearOnceDemoView: View {
    @State private var message = "初期状態"
    @State private var count = 0
    @State private var asyncMessage = "初期状態"
    @State private var asyncCount = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("OnAppearOnce モディファイアのデモ")
                .font(.title)
                .padding()
            
            Divider()
            
            // onAppearOnce デモセクション
            VStack(alignment: .leading, spacing: 10) {
                Text("onAppearOnce デモ")
                    .font(.headline)
                
                Text("メッセージ: \(message)")
                Text("カウント: \(count)")
                
                Button("画面を再描画") {
                    // 画面を強制的に再描画するための状態変更
                    count += 1
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
            // ここでonAppearOnceを使用
            .onAppearOnce {
                message = "onAppearOnce が一回だけ実行されました"
                print("onAppearOnce アクションが実行されました")
            }
            
            Divider()
            
            // taskOnce デモセクション
            VStack(alignment: .leading, spacing: 10) {
                Text("taskOnce デモ")
                    .font(.headline)
                
                Text("非同期メッセージ: \(asyncMessage)")
                Text("非同期カウント: \(asyncCount)")
                
                Button("画面を再描画") {
                    // 画面を強制的に再描画するための状態変更
                    asyncCount += 1
                }
            }
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(10)
            // ここでtaskOnceを使用
            .taskOnce {
                // 非同期処理を模擬
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1秒待機
                asyncMessage = "taskOnce が一回だけ実行されました"
                print("taskOnce アクションが実行されました")
            }
            
            Divider()
            
            // 比較のために通常のonAppearを使用
            VStack(alignment: .leading, spacing: 10) {
                Text("通常のonAppear（比較用）")
                    .font(.headline)
                
                Text("このセクションが再描画される度にonAppearが実行されます")
                Text("再描画カウント: \(count)")
            }
            .padding()
            .background(Color.red.opacity(0.1))
            .cornerRadius(10)
            .onAppear {
                print("通常のonAppearが実行されました（カウント: \(count)）")
            }
        }
        .padding()
    }
}

#Preview {
    OnAppearOnceDemoView()
} 