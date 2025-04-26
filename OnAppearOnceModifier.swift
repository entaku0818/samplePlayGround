import SwiftUI

/// 画面描画時に一度だけ処理を実行するモディファイア
struct OnAppearOnceModifier: ViewModifier {
    // 処理を実行するアクション
    let action: () -> Void
    
    // 実行済みフラグを保持するための状態変数
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                // まだ実行されていなければアクションを実行
                if !hasAppeared {
                    action()
                    hasAppeared = true
                }
            }
    }
}

/// 利便性のためにViewに拡張を追加
extension View {
    /// 画面描画時に一度だけ処理を実行するモディファイア
    /// - Parameter perform: 実行する処理
    /// - Returns: モディファイアが適用されたビュー
    func onAppearOnce(perform action: @escaping () -> Void) -> some View {
        modifier(OnAppearOnceModifier(action: action))
    }
}

/// Task実行版のモディファイア
struct TaskOnceModifier: ViewModifier {
    // 処理を実行するアクション
    let action: @Sendable () async -> Void
    
    // 実行済みフラグを保持するための状態変数
    @State private var hasExecuted = false
    
    func body(content: Content) -> some View {
        content
            .task {
                // まだ実行されていなければアクションを実行
                if !hasExecuted {
                    await action()
                    hasExecuted = true
                }
            }
    }
}

/// 利便性のためにViewに拡張を追加
extension View {
    /// 画面描画時に一度だけ非同期処理を実行するモディファイア
    /// - Parameter perform: 実行する非同期処理
    /// - Returns: モディファイアが適用されたビュー
    func taskOnce(perform action: @escaping @Sendable () async -> Void) -> some View {
        modifier(TaskOnceModifier(action: action))
    }
} 