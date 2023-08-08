//
//  CustomInput.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct CustomInput: View {
    @Binding var isPasswordInput: Bool
    @Binding var label: String
    @Binding var placeholder: String
    @Binding var icon: String
    @Binding var hint: String
    @Binding var showingError: Bool
    
    @State private var username: String = ""
    @FocusState private var emailFieldIsFocused: Bool

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
                if isPasswordInput {
                    SecureField(placeholder, text: $username)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(Font.custom("Poppins-Light", size: 15))
                        
                } else {
                    TextField(placeholder, text: $username)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .font(Font.custom("Poppins-Light", size: 15))
                }
                
                if !icon.isEmpty {
                    Button(action: iconButtonTap) {
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
            
            Text(label)
                .foregroundColor(showingError ? .red : .white)
                .opacity(showingError ? 1 : 0.6)
                .font(Font.custom("Poppins-Light", size: 13))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private func iconButtonTap() {
        
    }
}

//struct CustomInput_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomInput(isPasswordInput: true, label: "Label", placeholder: "Placeholder")
//    }
//}
