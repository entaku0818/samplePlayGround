//
//  CarouselView.swift
//  samplePlayGround
//
//  Created by takuya.endo on 2023/03/14.
//

import SwiftUI

/// A view that displays a carousel of views with automatic scrolling functionality.
/// The carousel automatically transitions between views at a fixed interval.
struct AutoScrollCarousel: View {
    /// Array of views to display in the carousel
    let views: [AnyView]
    
    /// Current index of the displayed view
    @State private var currentIndex = 0
    
    /// Timer that triggers view transitions every 3 seconds
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<views.count, id: \.self) { index in
                views[index]
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(height: 200)
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % views.count
            }
        }
    }
}

/// A custom Shape that creates an equilateral triangle.
/// This shape can be used as a visual element in views.
struct Triangle: Shape {
    /// Creates the triangle path within the provided rectangle.
    /// - Parameter rect: The rectangle that defines the shape's bounds
    /// - Returns: A Path representing an equilateral triangle
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

/// A sample view demonstrating the usage of AutoScrollCarousel with different shapes and colors.
struct CarouselHomeView: View {
    /// Sample views for the carousel, each containing a different shape and color combination
    let imageViews: [AnyView] = [
        AnyView(
            ZStack {
                Color(red: 0.3, green: 0.6, blue: 0.9)
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 100)
                Text("1")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
            }
        ),
        AnyView(
            ZStack {
                Color(red: 0.9, green: 0.4, blue: 0.3)
                Rectangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 100, height: 100)
                Text("2")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
            }
        ),
        AnyView(
            ZStack {
                Color(red: 0.4, green: 0.8, blue: 0.4)
                Triangle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 100, height: 100)
                Text("3")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
            }
        )
    ]

    var body: some View {
        VStack {
            AutoScrollCarousel(views: imageViews)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CarouselHomeView()
}
