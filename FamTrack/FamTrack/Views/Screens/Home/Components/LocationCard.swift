//
//  LocationCard.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/01.
//

import SwiftUI

struct LocationCard: View {
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "location.fill")
                .foregroundColor(Color("TextWhite"))
                .frame(width: 55, height: 55)
                .background(Color("Red"))
                .clipShape(Circle())
            
            Spacer()
                .frame(width: 15)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Home")
                    .foregroundColor(Color("Primary"))
                    .font(Font.custom("Poppins-Regular", size: 15))
                
                HStack(spacing: 15) {
                    Image(systemName: "mappin.and.ellipse")
                        .resizable()
                        .foregroundColor(Color("Primary"))
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 10)
                    
                    Text("Need to do this")
                        .foregroundColor(Color("Primary"))
                        .font(Font.custom("Poppins-Light", size: 13))
                }
            }
            
            Spacer()
        }
    }
}
