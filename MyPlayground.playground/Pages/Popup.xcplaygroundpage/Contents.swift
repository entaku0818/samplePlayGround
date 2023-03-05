
import UIKit
import SwiftUI
import PlaygroundSupport




struct ContentView: View {
    @State var isFirstPresented = false
    @State var isSecondPresented = false
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    self.isFirstPresented = true
                }, label: {
                    Text("Show Popup")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                })
                Button(action: {
                    self.isSecondPresented = true
                }, label: {
                    Text("Show Popup2")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                })
            }
            if isFirstPresented {
                PopupView(isPresented: $isFirstPresented)
            }
            if isSecondPresented {
                
                PopupImageView(isPresented: $isSecondPresented)
                
            }
        }.frame(width: 375, height: 700)
    }
    
}

struct PopupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in

            ZStack {
                PopupBackgroundView(isPresented: isPresented)
                    .transition(.opacity)
                PopupContentsView(isPresented:$isPresented)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.3)
                    .background(Color.gray)
                    .cornerRadius(20)
            }

        }
    }
}

struct PopupImageView: View {
    @Binding var isPresented: Bool
    var body: some View {
        GeometryReader { geometry in

            ZStack {
                PopupBackgroundView(isPresented: isPresented)
                    .transition(.opacity)
                PopupImageContentsView(isPresented: $isPresented)
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
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.white)
            Button(action: {
                isPresented = false
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
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            Image(systemName: "star.fill")
                .font(.system(size: 50))
            Button(action: {
                isPresented = false
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
