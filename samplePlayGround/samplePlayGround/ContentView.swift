//
//  ContentView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 11.3.2023.
//

import SwiftUI
import Lottie

/// The main content view of the application.
/// This view demonstrates the usage of Lottie animations by displaying
/// a congratulations animation in a centered frame.
struct ContentView: View {
    var body: some View {
        VStack {
            // Display the Lottie animation using the wrapper
            AnimationViewControllerWrapper(name: "congratulations")
                .frame(width: 300, height: 300)
        }
        .padding()
    }
}

/// SwiftUI preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
