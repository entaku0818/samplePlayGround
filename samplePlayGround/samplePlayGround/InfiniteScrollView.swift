import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let color: Color
    let number: Int
}

struct InfiniteScrollView: View {
    let items: [Item]
    let isReverse: Bool  // 回転方向を制御するためのプロパティを追加
    @State private var scrollOffset: CGFloat = 0
    @State private var dragOffset: CGFloat = 0

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
                .offset(x: scrollOffset + dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.width
                        }
                        .onEnded { value in
                            let totalWidth = CGFloat(items.count) * (itemWidth + spacing)
                            let predictedOffset = scrollOffset + dragOffset
                            dragOffset = 0

                            withAnimation(.linear) {
                                if predictedOffset > 0 {
                                    scrollOffset = -totalWidth + predictedOffset.truncatingRemainder(dividingBy: totalWidth)
                                } else if abs(predictedOffset) > totalWidth {
                                    scrollOffset = -(abs(predictedOffset).truncatingRemainder(dividingBy: totalWidth))
                                } else {
                                    scrollOffset = predictedOffset
                                }
                            }
                        }
                )
            }
            .onAppear {
                let totalWidth = CGFloat(items.count) * (itemWidth + spacing)
                withAnimation(.linear(duration: 15).repeatForever(autoreverses: false)) {
                    // 方向を制御
                    scrollOffset = isReverse ? totalWidth : -totalWidth
                }
            }
        }
        .frame(height: 120)
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
            // 通常の回転（左から右）
            InfiniteScrollView(items: items, isReverse: false)
            // 逆回転（右から左）
            InfiniteScrollView(items: items, isReverse: true)
            Spacer()
        }
        .padding()
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


#Preview {
    CollectionHomeView()
}
