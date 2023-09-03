//
//  LocationsTabView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/01.
//

import SwiftUI

struct LocationsTabView: View {
    @EnvironmentObject var userVM: UserStateViewModel
    
    var body: some View {
        VStack {
            Text("Places")
                .foregroundColor(Color("Primary"))
                .font(Font.custom("Poppins-Medium", size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        Spacer()
            .frame(height: 20)
        
        ScrollView() {
            VStack(spacing: 15) {
                NavigationLink {
                    
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 15, height: 15)
                            .padding(15)
                            .background(Color("SecondaryDarkBlue"))
                            .clipShape(Circle())
                        
                        Text("Add New Place")
                            .foregroundColor(Color("Primary"))
                            .font(Font.custom("Poppins-Regular", size: 15))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                ForEach(userVM.selectedGroupUsers) { user in
                    LocationCard()
                }
                
                Button(action: {
                    Task {
                       await userVM.signOut()
                    }
                }) {
                    Text("Logout")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Medium", size: 15))
                        .background(Color("SecondaryDarkBlue"))
                        .cornerRadius(10)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        
        Spacer()
            .frame(height: 10)
    }
}
