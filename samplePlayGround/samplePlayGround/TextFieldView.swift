//
//  TextView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 29.5.2023.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TextFieldView: View {

    @State private var text1: String = ""
    @State private var myMoney:Decimal.FormatStyle.Currency.FormatInput = 0
    @State private var myDouble:Double = 0.0
    @State private var numberFormatter: NumberFormatter = {
         var nf = NumberFormatter()
         nf.numberStyle = .decimal
         return nf
     }()
    @State private var text2: String = ""
    @State private var text3: String = ""
    @State private var text3Message: String = ""

    @State private var familyName = ""
    @FocusState private var familyNameFocused: Bool


     enum Field: Hashable {
         case username
         case password
     }

     @State private var username = ""
     @State private var password = ""
     @FocusState private var focusedField: Field?

    var body: some View {
        ScrollView{
            VStack {
                VStack{
                    TextField("test", text: $text1)
                        .textFieldStyle(.roundedBorder)
                    TextField("test", text: $text2, prompt: Text("Type something").foregroundColor(.red))
                        .textFieldStyle(.roundedBorder)

                }
                VStack{

                    TextField("Enter text", text: $text2, prompt: Text("Type long something"), axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                }

                TextField("Enter text", text: $text3)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: text3) { newValue in
                        text3Message = "入力文字数は\(text3.count)文字"
                    }
                Text(text3Message)
                TextField(
                    "Currency (USD)",
                    value: $myMoney,
                    format: .currency(code: "USD")
                ).textFieldStyle(.roundedBorder)

                VStack{
                    TextField(
                        value: $myDouble,
                        formatter: numberFormatter
                    ) {
                        Text("Double")
                    }.textFieldStyle(.roundedBorder)
                    Text(myDouble, format: .number.precision(.significantDigits(5)))
                    Text(myDouble, format: .number.notation(.scientific))

                    TextField("Username", text: $familyName)
                        .textFieldStyle(.roundedBorder)
                        .focused($familyNameFocused)
                        .toolbar{
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("閉じる") {
                                    familyNameFocused = false
                                    UIApplication.shared.endEditing()
                                }
                            }
                        }


                }
                VStack {
                    TextField("Username", text: $username)
                        .focused($focusedField, equals: .username)
                        .textFieldStyle(.roundedBorder)


                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusedField, equals: .password)

                    Button("Sign In") {
                        if username.isEmpty {
                            focusedField = .username
                        } else if password.isEmpty {
                            focusedField = .password
                        }
                    }
                }


                Spacer()


            }.padding(.horizontal)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView()
    }
}
