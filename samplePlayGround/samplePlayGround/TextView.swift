//
//  TextView.swift
//  samplePlayGround
//
//  Created by 遠藤拓弥 on 29.5.2023.
//

import SwiftUI

struct TextView: View {

    @State private var text1: String = ""
    @State private var myMoney:Decimal.FormatStyle.Currency.FormatInput = 0
    @State private var myDouble:Double = 0.0
     @State private var numberFormatter: NumberFormatter = {
         var nf = NumberFormatter()
         nf.numberStyle = .decimal
         return nf
     }()
    @State private var text2: String = ""
    @State private var givenName = ""
    @State private var familyName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var nameComponents = PersonNameComponents()



    func validate(components: PersonNameComponents) {
        if ((components.givenName?.isEmpty) != nil){
            return
        }
    }

    var body: some View {
        VStack {
            TextField("test", text: $text1)
            TextField("test", text: $text1)
                .textFieldStyle(.roundedBorder)
             TextField(
                 "Currency (USD)",
                 value: $myMoney,
                 format: .currency(code: "USD")
             ).textFieldStyle(.roundedBorder)
             .onChange(of: myMoney) { newValue in
                 print ("myMoney: \(newValue)")
             }
             TextField(
                 value: $myDouble,
                 formatter: numberFormatter
             ) {
                 Text("Double")
             }
             Text(myDouble, format: .number)
             Text(myDouble, format: .number.precision(.significantDigits(5)))
             Text(myDouble, format: .number.notation(.scientific))
            TextField("Enter text", text: $text2, prompt: Text("Type something"), axis: .vertical)
                .textFieldStyle(.roundedBorder)
             HStack {
                 TextField(
                     "Given Name",
                     text: $givenName
                 )
                 .disableAutocorrection(true)
                 TextField(
                     "Family Name",
                     text: $familyName
                 )
                 .disableAutocorrection(true)
             }
             .textFieldStyle(.roundedBorder)

            VStack{
                Form {
                    TextField(text: $username, prompt: Text("Required")) {
                        Text("Username")
                    }
                    SecureField(text: $password, prompt: Text("Required")) {
                        Text("Password")
                    }
                }
                TextField(
                    "Proper name",
                    value: $nameComponents,
                    format: .name(style: .medium)
                )
                .onSubmit {
                    validate(components: nameComponents)
                }
                .disableAutocorrection(true)
                .border(.secondary)
                Text(nameComponents.debugDescription)
            }


        }.padding(.horizontal)
    }

}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
