//
//  AnimationViewController.swift
//  samplePlayGround
//
//  Created by takuya.endo on 2023/03/14.
//

import Foundation
import SwiftUI
import UIKit
import Lottie

class AnimationViewController: UIViewController {

    init(name: String?) {
        self.name = name ?? "congratulations"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var name: String = "congratulations"

    var animationView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnimationView()
    }
    
    func addAnimationView() {
        view.frame = .zero
        // アニメーションファイルの指定
        animationView = LottieAnimationView(name: name)
        

        
        animationView.loopMode = .loop
        animationView.play()

        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

    }
}

struct AnimationViewControllerWrapper: UIViewControllerRepresentable {
    
    init(name: String?) {
        self.name = name ?? ""
    }
    
    var name: String = ""

    func makeUIViewController(context: Context) -> AnimationViewController {
        let viewController = AnimationViewController(name: name)

        return viewController
    }

    func updateUIViewController(_ uiViewController: AnimationViewController, context: Context) {
        // Do nothing
    }
}
