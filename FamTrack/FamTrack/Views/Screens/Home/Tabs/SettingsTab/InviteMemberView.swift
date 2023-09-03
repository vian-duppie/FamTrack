//
//  JoinGroupView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/02.
//

import SwiftUI

struct InviteMemberView: View {
    var groupCode: String
    var body: some View {
        VStack{
            ZStack {
                Image(systemName: "person.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100)
                
                Ellipse()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .background(Color("WhiteBlur"))
                    .opacity(0.07)
                    .blur(radius: 40)
            }
            .frame(maxWidth: .infinity, minHeight: 150)
            
            VStack(spacing: 5) {
                Text("Invite Members")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Share this code with members you would like to invite to your group")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 25)
            
            Text(groupCode)
                .foregroundColor(Color("Red"))
                .font(Font.custom("Poppins-Medium", size: 32))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Primary"))
    }
}
