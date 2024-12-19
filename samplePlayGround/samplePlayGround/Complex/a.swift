//
//  ExcessiveModifiersView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 2024/12/20.
//

import Foundation
import SwiftUI
struct ExcessiveModifiersView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding()
            .background(Color.yellow)
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 2)
            )
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(15)
            .shadow(radius: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.purple, lineWidth: 2)
            )
            .padding()
            .background(Color.orange.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 10)
            .scaleEffect(1.1)
            .rotationEffect(.degrees(5))
            .offset(x: 10, y: 10)
    }
}


#Preview {
    ExcessiveModifiersView()
}
