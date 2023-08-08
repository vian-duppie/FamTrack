//
//  CustomLineButton.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/08.
//

import SwiftUI

struct CustomLineButton: View {
    var label: String = "label"
    var clicked: () -> Void = {}
    var opacity: Double = 1
    
    var body: some View {
        Button(action: clicked) {
            Text(label)
                .foregroundColor(.white)
                .font(Font.custom("Poppins-Light", size: 13))
                .opacity(opacity > 0 ? opacity : 1)
                .underline()
        }
    }
}

struct CustomLineButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomLineButton()
    }
}
