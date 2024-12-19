//
//  ExcessiveModifiers2View.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 2024/12/20.
//

import SwiftUI

struct ExcessiveModifiers2View: View {
    @State private var isAnimating = false
    @State private var scale: CGFloat = 1.0
    @State private var rotation: Double = 0.0
    @State private var waveOffset: CGFloat = 0.0

    var body: some View {
        ZStack {
            HStack{
                VStack {
                    // 背景のアニメーション波形レイヤー
                    GeometryReader { geometry in
                        ForEach(0..<5) { index in
                            Path { path in
                                path.move(to: CGPoint(x: 0, y: geometry.size.height * 0.5))
                                path.addCurve(
                                    to: CGPoint(x: geometry.size.width, y: geometry.size.height * 0.5),
                                    control1: CGPoint(x: geometry.size.width * 0.25, y: geometry.size.height * 0.25),
                                    control2: CGPoint(x: geometry.size.width * 0.75, y: geometry.size.height * 0.75)
                                )
                            }
                            .stroke(Color.blue.opacity(0.2), lineWidth: 2)
                            .offset(x: waveOffset + CGFloat(index) * 10)
                            .animation(.linear(duration: 2).repeatForever(), value: waveOffset)
                        }
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.purple.opacity(0.2), .blue.opacity(0.2)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .overlay(
                            GeometryReader { geometry in
                                ForEach(0..<10) { index in
                                    Circle()
                                        .fill(Color.white.opacity(0.1))
                                        .frame(width: CGFloat(index) * 20, height: CGFloat(index) * 20)
                                        .position(
                                            x: geometry.size.width * CGFloat.random(in: 0...1),
                                            y: geometry.size.height * CGFloat.random(in: 0...1)
                                        )
                                        .scaleEffect(isAnimating ? 1.2 : 0.8)
                                        .animation(
                                            .easeInOut(duration: Double.random(in: 1...2))
                                            .repeatForever()
                                            .delay(Double(index) * 0.1),
                                            value: isAnimating
                                        )
                                }
                            }
                        )
                    )
                    
                    // メインコンテンツ
                    Text("Excessive Modifiers 2")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            ZStack {
                                ForEach(0..<3) { index in
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(Double(index) * 0.2), lineWidth: 2)
                                        .scaleEffect(isAnimating ? 1.0 + CGFloat(index) * 0.1 : 1.0)
                                        .rotation3DEffect(
                                            .degrees(rotation + Double(index) * 10),
                                            axis: (x: CGFloat(index), y: 1, z: 1)
                                        )
                                        .blur(radius: CGFloat(index))
                                        .animation(
                                            .easeInOut(duration: 1)
                                            .repeatForever()
                                            .delay(Double(index) * 0.2),
                                            value: isAnimating
                                        )
                                }
                            }
                        )
                        .overlay(
                            GeometryReader { geometry in
                                ForEach(0..<8) { index in
                                    Path { path in
                                        let radius = CGFloat(index) * 10
                                        path.addArc(
                                            center: CGPoint(x: geometry.size.width/2, y: geometry.size.height/2),
                                            radius: radius,
                                            startAngle: .degrees(rotation),
                                            endAngle: .degrees(rotation + 180),
                                            clockwise: true
                                        )
                                    }
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                                    .animation(
                                        .linear(duration: Double(index + 1))
                                        .repeatForever(autoreverses: false),
                                        value: isAnimating
                                    )
                                }
                            }
                        )
                        .shadow(color: .blue, radius: isAnimating ? 15 : 5)
                        .scaleEffect(scale)
                        .rotation3DEffect(
                            .degrees(rotation),
                            axis: (x: isAnimating ? 1 : 0, y: 1, z: isAnimating ? 1 : 0)
                        )
                        .modifier(ShimmerEffect(isAnimating: isAnimating))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.blue, .purple, .pink]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                                .blur(radius: isAnimating ? 2 : 0)
                                .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
                        )
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever()) {
                isAnimating.toggle()
                scale = 1.2
                rotation = 360
                waveOffset = 100
            }
        }
    }
}

// カスタムモディファイア
struct ShimmerEffect: ViewModifier {
    let isAnimating: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            .white.opacity(0.2),
                            .clear
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: geometry.size.width * 2)
                    .offset(x: isAnimating ? geometry.size.width : -geometry.size.width)
                    .blur(radius: 2)
                    .animation(
                        .linear(duration: 2)
                            .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
                }
            )
    }
}

#Preview {
    ExcessiveModifiers2View()
        .preferredColorScheme(.dark)
}
