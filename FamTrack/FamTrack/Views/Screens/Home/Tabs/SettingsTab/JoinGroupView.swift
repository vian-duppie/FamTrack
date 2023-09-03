//
//  JoinGroupView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/02.
//

import SwiftUI

struct JoinGroupView: View {
    @EnvironmentObject var userVM: UserStateViewModel
    
    @State var isCodeError: Bool = false
    @State var codeError: String = ""
    @State var codeValue: String = ""
    
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
                Text("Join Group")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Enter the code that was shared with you to join a group")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 25)
            
            CustomInput(
                label: "Group Code",
                placeholder: "Enter shared group code",
                showingError: isCodeError,
                hintLabel: codeError,
                value: $codeValue
            )
            
            Spacer()
            
            Button(action: joinGroup) {
                Text("Join Group")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Medium", size: 15))
            }
            .background(Color("SecondaryDarkBlue"))
            .cornerRadius(10)
            .lineLimit(1)
        }
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Primary"))
    }
    
    func joinGroup() {
        codeError = ""
        isCodeError = false
        
        if codeValue.isEmpty {
            isCodeError = true
            codeError = "Please enter a code"
            return
        }
        
        Task {
            let resultMessage = await userVM.joinGroupWithInviteCode(inviteCode: codeValue)
             codeError = resultMessage
             isCodeError = true
        }
    }
}
