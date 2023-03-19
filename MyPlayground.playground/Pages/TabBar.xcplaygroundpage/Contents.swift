

import UIKit
import SwiftUI
import Combine
import PlaygroundSupport



struct CustomTabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Text("First Tab Content")
                    .tag(0)
                
                Text("Second Tab Content")
                    .tag(1)
                
                UIViewControllerWrapper(uiViewController: ThirdViewController())
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(2)
                    
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .accentColor(.blue)
            
            
            TabBar(selectedTab: $selectedTab)
                .alignmentGuide(.bottom, computeValue: { dimension in
                    dimension[.bottom]
                })
        }.frame(width:375,height: 600)
    }
}



struct TabBarView: View {
            
    var body: some View {
        
        TabView {
            Text("First Tab")
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("First")
                }
            
            Text("Second Tab")
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }
            .badge(5)

            
            Text("Third Tab")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Third")
                }
            .badge("New")
        }
    }
}


struct TabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabBarItem(imageName: "house.fill", text: "Home", tag: 0, selectedTab: $selectedTab)
            TabBarItem(imageName: "list.bullet", text: "List", tag: 1, selectedTab: $selectedTab)
            TabBarItem(imageName: "person.fill", text: "Profile", tag: 2, selectedTab: $selectedTab)
        }
        .background(Color.white)
        .padding()
    }
}

struct TabBarItem: View {
    let imageName: String
    let text: String
    let tag: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = tag
        }) {
            VStack {
                  ZStack {
                      Image(systemName: imageName)
                          .font(.system(size: 24))
                      Badge(number: 1)
                          .offset(x: 10, y: -10)
                  }
                  Text(text)
                      .font(.footnote)
              }
              .foregroundColor(tag == selectedTab ? .blue : .gray)
              .padding(.vertical, 10)
              .frame(maxWidth: .infinity)
        }
    }
}

struct Badge: View {
    let number: Int
    
    var body: some View {
        Text("\(number)")
            .font(.system(size: 12))
            .foregroundColor(.white)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(Color.red)
            .clipShape(Circle())
    }
}

struct UIViewControllerWrapper: UIViewControllerRepresentable {
    let uiViewController: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}


class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a label to the view controller's view
        let label = UILabel(frame: CGRect(x: view.bounds.width / 2, y: view.bounds.height / 2, width: 200, height: 50))
        label.center = view.center
        label.textAlignment = .center
        label.text = "Third Tab Content"
        
        view.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: label.topAnchor),
                view.bottomAnchor.constraint(equalTo: label.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: label.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: label.trailingAnchor)
            ]
        )
    }
}

PlaygroundPage.current.liveView = UIHostingController(rootView:
                                                        TabBarView())
