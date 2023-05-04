//
//  SwiftUIView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 4.5.2023.
//

import SwiftUI

struct HalfModalView: View {
    @State private var isModalPresented = false
    @State private var isBeforeiOS15ModalPresented = false


    var body: some View {
        ZStack {
            VStack {
                Text("Main Content")
                    .font(.title)
                
                Button(action: {
                    isModalPresented.toggle()
                }) {
                    Text("Show Half Modal")
                        .font(.headline)
                }
                Button(action: {
                    isBeforeiOS15ModalPresented.toggle()
                }) {
                    Text("BeforeiOS15ModalPresented")
                        .font(.headline)
                }.padding()
            }
            .sheet(isPresented: $isModalPresented, content: {
                VStack {
                    Spacer()
                    
                    Text("Half Modal Content")
                        .font(.title)
                        .padding()
                    
                    
                    
                    Spacer()
                    
                    Button(action: {
                        isModalPresented.toggle()
                    }) {
                        Text("Close")
                            .font(.headline)
                    }
                    .padding()
                    
                    
                }
                .background(Color.white.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                .presentationDetents([.medium])
            })
            if isBeforeiOS15ModalPresented {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isBeforeiOS15ModalPresented.toggle()
                    }
                VStack{
                    Spacer()
                    HStack(alignment: .bottom){
                        BeforeiOS15HalfModalView(isModalPresented: $isBeforeiOS15ModalPresented)
                            .frame( height: 400)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding()
                    }.frame(maxWidth: .infinity)
                        .background(Color.white)
                }


            }
        }



    }
}



struct BeforeiOS15HalfModalView: View {
    @Binding var isModalPresented: Bool

    var body: some View {
        VStack {
            Spacer()

            Text("Half Modal Content")
                .font(.title)

            Button(action: {
                isModalPresented.toggle()
            }) {
                Text("Close")
                    .font(.headline)
            }
        }
    }
}

struct HalfModalView_Previews: PreviewProvider {
    static var previews: some View {
        HalfModalView()
    }
}
