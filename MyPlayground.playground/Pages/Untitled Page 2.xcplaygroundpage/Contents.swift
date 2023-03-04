
import UIKit
import SwiftUI
import Combine
import PlaygroundSupport


protocol PopupAction: AnyObject {
    func onFirstTapped()
    func onSecondTapped()
}

struct ContentView: View {
    @State var isFirstPresented = false
    @State var isSecondPresented = false
    private var delegate: PopupAction {
        PopupActionDelegate(isFirstPresented: $isFirstPresented,isSecondPresented: $isSecondPresented)
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isFirstPresented = true
            }, label: {
                Text("Show Popup")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            })
            if isFirstPresented {
                
                PopupView(isPresented: isFirstPresented, delegate: delegate)
                
            }
            if isSecondPresented {
                
                PopupImageView(isPresented: isSecondPresented, delegate: delegate)
                
            }
        }.frame(width: 375, height: 700)
    }
    
    private final class PopupActionDelegate: PopupAction {
        @Binding var isFirstPresented: Bool
        @Binding var isSecondPresented: Bool
        init(isFirstPresented: Binding<Bool>,isSecondPresented: Binding<Bool>) {
            self._isFirstPresented = isFirstPresented
            self._isSecondPresented = isSecondPresented
        }
        func onFirstTapped() {
            self.isFirstPresented = false
            self.isSecondPresented = true
        }
        
        func onSecondTapped() {
            self.isSecondPresented = false
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

struct PopupImageView: View {
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
                PopupImageContentsView(delegate: delegate)
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
                delegate.onFirstTapped()
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

struct PopupImageContentsView: View {
    private var delegate: PopupAction
    init(
        delegate: PopupAction
    ) {
        self.delegate = delegate
    }
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .font(.system(size: 50))
            Button(action: {
                delegate.onSecondTapped()
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
