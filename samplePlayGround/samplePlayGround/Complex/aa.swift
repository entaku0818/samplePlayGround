//
//  aa.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 2024/12/20.
//

import Foundation
import SwiftUI

struct ExcessiveModifiers1View: View {
    @State private var isAnimating = false
    @State private var scale: CGFloat = 1.0

    var body: some View {
        Text("Hello, SwiftUI!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .padding()
            .background(
                ZStack {
                    Color.yellow
                    Circle()
                        .fill(Color.red.opacity(0.3))
                        .scaleEffect(isAnimating ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
                }
            )
            .cornerRadius(10)
            .shadow(radius: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 2)
                    .overlay(
                        HStack {
                            ForEach(0..<5) { index in
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 10, height: 10)
                                    .scaleEffect(scale)
                                    .animation(.easeInOut(duration: 0.5).repeatForever(), value: scale)
                            }
                        }
                        .padding()
                    )
            )
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.green, .blue]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .overlay(
                    GeometryReader { geometry in
                        Path { path in
                            path.addLines([
                                .init(x: 0, y: 0),
                                .init(x: geometry.size.width, y: geometry.size.height)
                            ])
                        }
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    }
                )
            )
            .cornerRadius(15)
            .shadow(color: .purple, radius: 8, x: 5, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.purple, lineWidth: 2)
                    .blur(radius: 2)
            )
            .padding()
            .background(Color.orange.opacity(0.2))
            .cornerRadius(20)
            .shadow(radius: 10)
            .rotation3DEffect(.degrees(isAnimating ? 5 : -5), axis: (x: 1, y: 0, z: 0))
            .scaleEffect(isAnimating ? 1.1 : 1.0)
            .offset(x: isAnimating ? 10 : -10, y: isAnimating ? 10 : -10)
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever()) {
                    isAnimating.toggle()
                    scale = 1.5
                }
            }
    }
}

#Preview {
    ExcessiveModifiers1View()
}
