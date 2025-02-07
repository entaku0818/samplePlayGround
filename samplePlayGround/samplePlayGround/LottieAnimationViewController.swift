//
//  LottieAnimationViewController.swift
//  samplePlayGround
//
//  Created by takuya.endo on 2023/03/14.
//

import Foundation
import SwiftUI
import UIKit
import Lottie

/// A view controller that manages and displays Lottie animations.
/// This controller handles the setup and playback of JSON-based Lottie animations.
class AnimationViewController: UIViewController {

    /// Initializes the animation view controller with a specified animation name.
    /// - Parameter name: The name of the Lottie animation JSON file (without extension).
    ///                  Defaults to "congratulations" if nil is provided.
    init(name: String?) {
        self.name = name ?? "congratulations"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// The name of the animation file to be played
    var name: String = "congratulations"

    /// The Lottie animation view that displays the animation
    var animationView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnimationView()
    }
    
    /// Sets up and configures the Lottie animation view
    func addAnimationView() {
        view.frame = .zero
        // Configure the animation view with the specified animation file
        animationView = LottieAnimationView(name: name)
        
        // Set animation to loop continuously
        animationView.loopMode = .loop
        animationView.play()

        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

/// A SwiftUI wrapper for the AnimationViewController that enables using Lottie animations in SwiftUI views.
struct AnimationViewControllerWrapper: UIViewControllerRepresentable {
    
    /// Initializes the wrapper with an animation name
    /// - Parameter name: The name of the Lottie animation file to display
    init(name: String?) {
        self.name = name ?? ""
    }
    
    /// The name of the animation file
    var name: String = ""

    /// Creates and returns an AnimationViewController configured with the specified animation
    func makeUIViewController(context: Context) -> AnimationViewController {
        let viewController = AnimationViewController(name: name)
        return viewController
    }

    /// Updates the view controller with new data (not used in this implementation)
    func updateUIViewController(_ uiViewController: AnimationViewController, context: Context) {
        // Do nothing
    }
}
