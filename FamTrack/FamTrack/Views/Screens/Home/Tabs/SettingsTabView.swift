//
//  SettingsTabView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/02.
//

import SwiftUI

struct SettingsTabView: View {
    var body: some View {
        VStack {
            NavigationLink {
                ApplicationSwitcher()
            } label: {
                Text("Login")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Medium", size: 15))
                    .frame(maxWidth: true ? .infinity : 150)
                    .background(Color("SecondaryDarkBlue"))
                    .cornerRadius(10)
                    .lineLimit(1)
            }
            
            Spacer()
                .frame(height: 20)
            
            NavigationLink {
                ApplicationSwitcher()
            } label: {
                Text("Login")
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Medium", size: 15))
                    .frame(maxWidth: true ? .infinity : 150)
                    .background(Color("SecondaryDarkBlue"))
                    .cornerRadius(10)
                    .lineLimit(1)
            }
        }
    }
}

struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
