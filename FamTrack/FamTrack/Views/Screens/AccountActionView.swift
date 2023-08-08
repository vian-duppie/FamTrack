//
//  AccountActionView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/08.
//

import SwiftUI

struct AccountActionView: View {
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "person.line.dotted.person")
                     .resizable()
                     .scaledToFit()
                     .frame(maxWidth: 150, maxHeight: 100)
                 
                Ellipse()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .background(Color("WhiteBlur"))
                    .opacity(0.07)
                    .blur(radius: 70)
             }
            
            Spacer()
                .frame(height: 30)
            
            VStack(spacing: 30) {
                Text("Join the FamTrack Family now!")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 10) {
                    Text("Create your account now or just log in if you are already apart of the fam.")
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Regular", size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Spacer()
                .frame(height: 30)
            
            HStack {
                CustomButton(label: "Login", expand: true)
                
                Spacer()
                    .frame(width: 15)
                
                CustomButton(label: "Sign Up", expand: true)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct AccountActionView_Previews: PreviewProvider {
    static var previews: some View {
        AccountActionView()
    }
}
