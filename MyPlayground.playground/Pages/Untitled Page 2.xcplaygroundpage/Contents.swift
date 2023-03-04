
import UIKit
import SwiftUI
import Combine
import PlaygroundSupport

struct ContentView: View {
    @State var isPresented = false
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isPresented = true
            }, label: {
                Text("Show Popup")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            })
            if isPresented {
                PopupBackgroundView(isPresented: $isPresented)
                    .transition(.opacity)
                PopupView()
                    .transition(.scale)
            }
        }.frame(width: 750, height: 500)
    }
}

struct PopupBackgroundView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Color.black.opacity(0.4)
            .onTapGesture {
                self.isPresented = false
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct PopupView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.white)
            Button(action: {
                // ボタンをクリックしたときのアクション
            }, label: {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
            })
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color.gray)
        .cornerRadius(20)
    }
}

PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())
