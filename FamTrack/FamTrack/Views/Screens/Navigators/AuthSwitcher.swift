//
//  AuthSwitcher.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/16.
//

import SwiftUI

struct AuthSwitcher: View {
    @EnvironmentObject var userVM: UserStateViewModel
    var body: some View {
        if userVM.showLogin {
            LoginView()
        } else {
            SignUpView()
        }
    }
}

struct AuthSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        AuthSwitcher()
    }
}
