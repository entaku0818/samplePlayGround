
import UIKit
import SwiftUI
import Combine
import PlaygroundSupport


protocol PopupAction: AnyObject {
    func onTapped()
}

struct ContentView: View {
    @State var isPresented = false
    private var delegate: PopupAction {
        PopupActionDelegate(isPresented: $isPresented)
    }
    
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
                PopupView(isPresented: isPresented, delegate: delegate)
            }
        }.frame(width: 375, height: 700)
    }
    
    private final class PopupActionDelegate: PopupAction {
        @Binding var isPresented: Bool
        
        init(isPresented: Binding<Bool>) {
            self._isPresented = isPresented
        }
        
        func onTapped() {
            isPresented = false
        }
    }
}

struct PopupView: View {
    @State var isPresented: Bool
    private var delegate: PopupAction
    init(
        isPresented: Bool,
        delegate: PopupAction
    ) {
        self.isPresented = isPresented
        self.delegate = delegate
    }
    
    var body: some View {
        GeometryReader { geometry in

            ZStack {
                PopupBackgroundView(isPresented: isPresented)
                    .transition(.opacity)
                PopupContentsView(delegate: delegate)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                    .background(Color.gray)
                    .cornerRadius(20)
            }

        }
    }
}

struct PopupBackgroundView: View {
    @State var isPresented: Bool
    
    var body: some View {
        Color.black.opacity(0.3)
            .onTapGesture {
                self.isPresented = false
            }
            .edgesIgnoringSafeArea(.all)
    }
}

struct PopupContentsView: View {
    private var delegate: PopupAction
    init(
        delegate: PopupAction
    ) {
        self.delegate = delegate
    }
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.white)
            Button(action: {
                delegate.onTapped()
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
