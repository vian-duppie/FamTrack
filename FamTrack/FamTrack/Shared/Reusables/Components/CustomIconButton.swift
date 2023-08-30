//
//  CustomIconButton.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct CustomIconButton: View {
    var icon: String = ""
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                 .resizable()
                 .scaledToFit()
                 .frame(maxWidth: 20)
                 .padding(20)
                 .background(Color("SecondaryDarkBlue"))
                 .clipShape(Circle())
                 .foregroundColor(.white)
        }
    }
}

struct CustomIconButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomIconButton()
    }
}
