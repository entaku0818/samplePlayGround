import SwiftUI


struct Item: Identifiable {
    let id = UUID()
    let color: Color
    let number: Int
}

// 左から右へのスクロールビュー
struct LeftToRightScrollView: View {
    let items: [Item]
    @State private var scrollOffset: CGFloat = 0
    @State private var isFirstAppear = true

    var body: some View {
        GeometryReader { geometry in
            let itemWidth: CGFloat = geometry.size.width / 3.5
            let spacing: CGFloat = 10
            let singleSetWidth = CGFloat(items.count) * (itemWidth + spacing) - spacing
            let totalScrollWidth = (singleSetWidth * 3)
            let initialOffset = -(totalScrollWidth - geometry.size.width)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(0..<3) { _ in
                        ForEach(items) { item in
                            ItemView(item: item, width: itemWidth)
                        }
                    }
                }
                .offset(x: scrollOffset)
                .allowsHitTesting(false) // タッチ操作を無効化
            }
            .onAppear {
                if isFirstAppear {
                    scrollOffset = initialOffset
                    isFirstAppear = false

                    let totalWidth = CGFloat(items.count) * (itemWidth + spacing)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.linear(duration: 15).repeatForever(autoreverses: false)) {
                            scrollOffset = initialOffset + totalWidth
                        }
                    }
                }
            }
            .simultaneousGesture(DragGesture()) // スクロール操作を無効化
        }
        .frame(height: 120)
    }
}

struct RightToLeftScrollView: View {
    let items: [Item]
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let itemWidth: CGFloat = geometry.size.width / 3.5
            let spacing: CGFloat = 10

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: spacing) {
                    ForEach(0..<3) { _ in
                        ForEach(items) { item in
                            ItemView(item: item, width: itemWidth)
                        }
                    }
                }
                .offset(x: scrollOffset)
                .allowsHitTesting(false)
            }
            .onAppear {
                let totalWidth = CGFloat(items.count) * (itemWidth + spacing)
                withAnimation(.linear(duration: 15).repeatForever(autoreverses: false)) {
                    scrollOffset = -totalWidth
                }
            }
            .simultaneousGesture(DragGesture())
        }
        .frame(height: 120)
    }
}

struct ItemView: View {
    let item: Item
    let width: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(item.color)
            .frame(width: width, height: width)
            .overlay(
                Text("\(item.number)")
                    .foregroundColor(.white)
                    .font(.title)
            )
    }
}

struct CollectionHomeView: View {
    let items = [
        Item(color: .blue, number: 1),
        Item(color: .red, number: 2),
        Item(color: .green, number: 3),
        Item(color: .orange, number: 4),
        Item(color: .purple, number: 5),
        Item(color: .pink, number: 6)
    ]

    var body: some View {
        VStack {
            // 左から右へのスクロール
            LeftToRightScrollView(items: items)
            // 右から左へのスクロール
            RightToLeftScrollView(items: items)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CollectionHomeView()
}
