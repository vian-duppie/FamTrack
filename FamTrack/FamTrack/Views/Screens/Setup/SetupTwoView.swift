//
//  SetupTwoView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/10.
//

import SwiftUI

struct SetupTwoView: View {
    @AppStorage("setupDone") var isSetupDone: Bool = false
    @EnvironmentObject var setupVM: SetupViewModel
    
    let roleOptions: [String] = ["Parent", "Friend", "Leader", "Other"]
    @State var selectedRole: String = "Parent"
    
    @State var isGroupNameError: Bool = false
    @State var groupNameHint: String = ""
    @State var groupNameValue: String = ""
    
    var body: some View {
        ZStack {
            if setupVM.isBusy {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.3))
                    .zIndex(1)
            }
            
            VStack {
                VStack(spacing: 30) {
                    Text("Group Role & Name")
                        .foregroundColor(Color("SecondaryDarkBlue"))
                        .font(Font.custom("Poppins-Medium", size: 32))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("What would you describe your role as in this group?")
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Regular", size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
                    .frame(height: 35)
                
                VStack(spacing: 25) {
                    ForEach(roleOptions, id: \.self) { role in
                        Button(action: {
                            setupVM.selectedRole = role
                        }) {
                            Text(role)
                                .frame(minWidth: 120)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .font(Font.custom("Poppins-Medium", size: 15))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("Red"), lineWidth: 2)
                                )
                                .background(setupVM.selectedRole == role ? Color("Red") : .clear)
                                .cornerRadius(10)
                                .lineLimit(1)
                        }
                    }
                }
                
                Spacer()
                
                CustomInput(
                    label: "Group Name",
                    placeholder: "What would you like to call this group ?",
                    showingError: isGroupNameError,
                    hintLabel: groupNameHint,
                    value: $setupVM.groupName
                )
                .onChange(of: setupVM.groupName) { value in
                    isGroupNameError = false
                    groupNameHint = ""
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        createGroup()
                    }) {
                        Text("Continue")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 15))
                            .background(Color("SecondaryDarkBlue"))
                            .cornerRadius(10)
                            .lineLimit(1)
                    }
    //                .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Spacer()
                        .frame(height: 15)
                    
                    Button(action: {
                        withAnimation {
                            isSetupDone = true
                        }
                    }) {
                        Text("Skip")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 16))
                    }
    //                .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func createGroup() {
        if setupVM.groupName.isEmpty {
            isGroupNameError = true
            groupNameHint = "Enter group name"
            return
        }
//        setupVM.groupName = groupNameValue
        setupVM.currentView += 1
    }
}

struct SetupTwoView_Previews: PreviewProvider {
    static var previews: some View {
        SetupTwoView()
    }
}
