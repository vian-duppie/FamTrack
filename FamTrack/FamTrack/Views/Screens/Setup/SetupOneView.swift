//
//  SetupOneView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/10.
//

import SwiftUI

struct SetupOneView: View {
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Image("GridMap")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Image("RedPin")
                    .position(x: 40, y: 40)
                
                Image("RedPin")
                    .position(x: 120, y: 130)
                
                Image("BluePin")
                    .position(x: 150, y: 50)
                
                Ellipse()
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .background(Color("WhiteBlur"))
                    .opacity(0.2)
                    .blur(radius: 100)
                    .zIndex(12)
            }
            .frame(maxWidth: 200, maxHeight: 200)
            
            Spacer()
                .frame(height: 40)
            
            VStack(spacing: 30) {
                Text("Welcome user")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("You can now create your own group and invite members to join it!")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SetupOneView_Previews: PreviewProvider {
    static var previews: some View {
        SetupOneView()
    }
}
