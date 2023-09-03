//
//  SetupView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/10.
//

import SwiftUI

struct SetupView: View {
    @StateObject var setupViewModel = SetupViewModel()
    @State private var currentSetupView = 0
    
    var views: [AnyView] = [
        AnyView(SetupOneView()),
        AnyView(SetupTwoView()),
        AnyView(SetupFourView())
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            views[setupViewModel.currentView]
                .environmentObject(setupViewModel)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarHidden(true)
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
