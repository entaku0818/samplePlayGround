import SwiftUI

struct AutoScrollCarousel: View {
    let views: [AnyView]
    @State private var currentIndex = 0
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

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct CarouselHomeView: View {
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
