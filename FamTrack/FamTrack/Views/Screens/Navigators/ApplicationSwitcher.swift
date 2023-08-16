//
//  ApplicationSwitcher.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/16.
//

import SwiftUI

struct ApplicationSwitcher: View {
    @EnvironmentObject var userVM: UserStateViewModel
    var body: some View {
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
