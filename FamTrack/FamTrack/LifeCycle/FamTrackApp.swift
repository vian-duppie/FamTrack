//
//  FamTrackApp.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/05.
//

import SwiftUI
import Firebase

@main
struct FamTrackApp: App {
    @AppStorage("onboardingDone") var isOnboardingDone: Bool = false
    @StateObject var userStateViewModel = UserStateViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashView(
                    mainView: {
                        if isOnboardingDone {
                            ApplicationSwitcher()
                        } else {
                            OnboardingView()
                        }
                    }
                )
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
        }
    }
}

struct ApplicationSwitcher: View {
    @EnvironmentObject var userVM: UserStateViewModel
    
    var body: some View {
        if userVM.isLoggedIn {
            ContentView()
        } else {
            LoginView()
        }
    }
}
