
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
                PopupView(isPresented: $isPresented)
            }
        }.frame(width: 375, height: 700)
    }
}

struct PopupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in

            ZStack {
                PopupBackgroundView(isPresented: $isPresented)
                    .transition(.opacity)
                PopupContentsView()
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                    .background(Color.gray)
                    .cornerRadius(20)
            }

        }
    }
}

struct PopupBackgroundView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Color.black.opacity(0.3)
            .onTapGesture {
                self.isPresented = false
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct PopupContentsView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.white)
            Button(action: {
                
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
    
    }
}



PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())
