//
//  ApplicationSwitcher.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/16.
//

import SwiftUI

struct ApplicationSwitcher: View {
    @AppStorage("setupDone") var isSetupDone: Bool = false
    
    @EnvironmentObject var userVM: UserStateViewModel
    var body: some View {
        if userVM.isLoggedIn {
            if isSetupDone {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            } else {
                SetupView()
            }
        } else {
            AuthSwitcher()
                .onAppear {
                    userVM.checkAuth()
                }
        }
    }
}

struct ApplicationSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationSwitcher()
    }
}
