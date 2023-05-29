import SwiftUI
import PlaygroundSupport


struct TextEditorContentView: View {
    @State private var singleLineText: String = ""
    @State private var multiLineText: String = ""

    var body: some View {
        TextField("Single Line", text: $singleLineText)
            .textFieldStyle(.roundedBorder)
            .padding()


    }
}

PlaygroundPage.current.setLiveView(TextEditorContentView())
