//
//  AuthenticationLayout.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/08.
//

import SwiftUI

struct AuthenticationLayout<Content: View>: View {
    @ViewBuilder var formContent: Content
    
    var heading: String = "Heading"
    var subHeading: String = "Subheading"
    var mainAction: () -> Void = {}
    var secondaryAction: () -> Void = {}
    var lineButtonLabel: String = "Line Label"
    var lineButtonText: String = "Line Button Text"
    var lineButtonOpacity: Double = 1
    var buttonLabel: String = "Button"
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    Image("Shape")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 100)
                    
                    Ellipse()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .background(Color("WhiteBlur"))
                        .opacity(0.5)
                        .blur(radius: 120)
                }
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            
            Spacer()
            
            VStack(spacing: 30) {
                VStack(spacing: 5) {
                    Text(heading)
                        .foregroundColor(Color("SecondaryDarkBlue"))
                        .font(Font.custom("Poppins-Medium", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(subHeading)
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Regular", size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    formContent
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 30)
            
            Spacer()
            
            VStack(spacing: 10) {
                CustomButton(label: buttonLabel, clicked: mainAction)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                HStack {
                    Text(lineButtonLabel)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Light", size: 13))
                        .opacity(lineButtonOpacity > 0 ? lineButtonOpacity : 1)
                    
                    CustomLineButton(label: lineButtonText, clicked: secondaryAction, opacity: lineButtonOpacity)
//                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.vertical, 10)
        .padding(.bottom, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
