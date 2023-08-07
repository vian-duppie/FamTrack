//
//  OnboardingLayout.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct OnboardingLayout: View {
    var image = "questionmark.app"
    var heading = "Heading"
    var descriptionOne = "First Description"
    var descriptionTwo = "Second Description"
    
    var body: some View {
        ZStack {
            Image(systemName: image)
                 .resizable()
                 .scaledToFit()
                 .frame(maxWidth: 150, maxHeight: 100)
             
//             Ellipse()
//             .frame(maxWidth: 150, maxHeight: 150)
//             .background(Color("WhiteBlur"))
//             .opacity(0.07)
//             .blur(radius: 40)
         }
         
         Spacer()
             .frame(height: 30)
         
         VStack(spacing: 30) {
             Text(heading)
                 .foregroundColor(Color("SecondaryDarkBlue"))
                 .font(Font.custom("Poppins-Medium", size: 32))
                 .frame(maxWidth: .infinity, alignment: .leading)
             
             VStack(spacing: 10) {
                 Text(descriptionOne)
                     .foregroundColor(Color("TextWhite"))
                     .font(Font.custom("Poppins-Regular", size: 17))
                     .frame(maxWidth: .infinity, alignment: .leading)
                 
                 Text(descriptionTwo)
                     .foregroundColor(Color("TextWhite"))
                     .font(Font.custom("Poppins-Regular", size: 17))
                     .frame(maxWidth: .infinity, alignment: .leading)
             }
         }
    }
}

struct OnboardingLayout_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingLayout()
    }
}
