//
//  CustomButton.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/08.
//

import SwiftUI

struct CustomButton: View {
    var label: String = "label"
    var clicked: () -> Void = {}
    var expand: Bool = false
    
    var body: some View {
        Button(action: clicked) {
            Text(label)
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .foregroundColor(.white)
                .font(Font.custom("Poppins-Medium", size: 15))
        }
        .frame(maxWidth: expand ? .infinity : 150)
        .background(Color("SecondaryDarkBlue"))
        .cornerRadius(10)
        .lineLimit(1)
    }
}
