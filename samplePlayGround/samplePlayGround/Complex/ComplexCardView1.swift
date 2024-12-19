//
//  File.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 2024/12/20.
//

import SwiftUI
struct CardTitleView: View {
    var body: some View {
        Text("Super Long Title That Needs To Be Displayed")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .padding()
            .background(Color.yellow.opacity(0.3))
            .cornerRadius(8)
    }
}

// レーティング部分を別コンポーネントに分離
struct RatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .foregroundColor(index < rating ? .yellow : .gray)
                    .onTapGesture {
                        rating = index + 1
                    }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct ComplexCardView1: View {
    @State private var isExpanded = false
    @State private var rating = 0

    var body: some View {
        VStack {
            HStack {
                VStack {
                    CardTitleView()
                    RatingView(rating: $rating)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
        }
    }
}

#Preview {
    ComplexCardView1()
}
