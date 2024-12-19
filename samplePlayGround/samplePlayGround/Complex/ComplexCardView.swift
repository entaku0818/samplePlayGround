//
//  ComplexCardView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 2024/12/20.
//

import Foundation
import SwiftUI
//
//struct ComplexCardView: View {
//    @State private var isExpanded = false
//    @State private var rating = 0
//
//    var body: some View {
//        VStack {
//            HStack {
//                VStack {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.white)
//                            .shadow(radius: 5)
//                            .overlay(
//                                VStack {
//                                    HStack {
//                                        Text("Super Long Title That Needs To Be Displayed")
//                                            .font(.title)
//                                            .fontWeight(.bold)
//                                            .foregroundColor(.black)
//                                            .padding()
//                                            .background(Color.yellow.opacity(0.3))
//                                            .cornerRadius(8)
//                                            .shadow(radius: 3)
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 8)
//                                                    .stroke(Color.gray, lineWidth: 1)
//                                            )
//                                    }
//                                    .padding()
//                                    .background(Color.blue.opacity(0.1))
//                                    .cornerRadius(10)
//                                    .overlay(
//                                        VStack {
//                                            ForEach(0..<5) { index in
//                                                HStack {
//                                                    Image(systemName: "star.fill")
//                                                        .foregroundColor(index < self.rating ? .yellow : .gray)
//                                                        .onTapGesture {
//                                                            self.rating = index + 1
//                                                        }
//                                                }
//                                                .padding()
//                                                .background(Color.white)
//                                                .cornerRadius(8)
//                                                .shadow(radius: 2)
//                                            }
//                                        }
//                                    )
//                                }
//                            )
//                    }
//                }
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(15)
//                .shadow(radius: 8)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 15)
//                        .stroke(Color.blue, lineWidth: 2)
//                )
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(20)
//            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
//        }
//    }
//}
//
//
//#Preview {
//    ComplexCardView()
//}
