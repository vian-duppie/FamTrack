//
//  CustomInput.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct CustomInput: View {
    var isPasswordInput: Bool?
    var label: String
    var placeholder: String
    var icon: String = ""
    var showingError: Bool = false
    var iconClicked: () -> Void = {}
    var hintLabel = ""
    
    @Binding var value: String

    var body: some View {
        VStack {
            Text(label)
                .foregroundColor(.white)
//                .opacity(0.6)
                .font(Font.custom("Poppins-Medium", size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                if isPasswordInput ?? false {
                    SecureField(placeholder, text: $value)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(Font.custom("Poppins-Light", size: 15))
                        
                } else {
                    TextField(placeholder, text: $value)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(Font.custom("Poppins-Light", size: 15))
                }
                
                if !icon.isEmpty {
                    Button(action: iconClicked) {
                        Image(systemName: icon)
                             .resizable()
                             .scaledToFit()
                             .frame(maxWidth: 20)
                             .foregroundColor(.white)
                    }
                }
            }
            
            Rectangle()
                .frame(height: 2)
                .foregroundColor(showingError ? .red : Color("SecondaryDarkBlue"))
            
            Spacer()
                .frame(height: 5)
            
            Text(hintLabel)
                .foregroundColor(showingError ? .red : .white)
                .opacity(showingError ? 1 : 0.6)
                .font(Font.custom("Poppins-Light", size: 13))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private func iconButtonTap() {
        print("The icon has been pressed")
    }
}

//struct CustomInput_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInput(isPasswordInput: true, label: "Label", placeholder: "Placeholder")
//    }
//}
