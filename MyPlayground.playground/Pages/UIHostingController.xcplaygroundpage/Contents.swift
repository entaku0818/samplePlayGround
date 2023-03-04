
import UIKit
import SwiftUI
import Combine
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        setupUIkit()

        let host = UIHostingController(rootView: DebugView())
        setupUI(hostingController: host)
    }
    
    func setupUIkit() -> Void {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 200, y: 200, width: 200, height: 20)
        label.text = "1枚目だよ"
        label.textColor = .black
        view.addSubview(label)
        
        self.view = view
    }
}

struct DebugView: View {
    var body: some View {
        Text("2枚目だよ")
        .foregroundColor(Color.blue)
        
    }
}


extension UIViewController {
    func setupUI(hostingController: UIHostingController<some View>) {
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        )
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
