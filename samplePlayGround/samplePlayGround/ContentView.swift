//
//  ContentView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 11.3.2023.
//

import SwiftUI
import Lottie

struct ContentView: View {
    var body: some View {
        VStack {
            AnimationViewControllerWrapper(name: "congratulations")
                .frame(width: 300, height: 300)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




