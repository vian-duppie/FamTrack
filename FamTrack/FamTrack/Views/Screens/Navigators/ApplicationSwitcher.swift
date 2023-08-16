//
//  ApplicationSwitcher.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/16.
//

import SwiftUI

struct ApplicationSwitcher: View {
    var body: some View {
        @EnvironmentObject var userVM: UserStateViewModel
        if userVM.isLoggedIn {
            SetupView()
        } else {
            AuthSwitcher()
        }
    }
}

struct ApplicationSwitcher_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationSwitcher()
    }
}
