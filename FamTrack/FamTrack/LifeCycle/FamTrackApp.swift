//
//  FamTrackApp.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/05.
//

import SwiftUI

@main
struct FamTrackApp: App {
    @AppStorage("onboardingDone") var isOnboardingDone: Bool = false
    @StateObject var userStateViewModel = UserStateViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashView(
                    mainView: {
                        if isOnboardingDone {
                            LoginView()
                        } else {
                            OnboardingView()
                        }
                    }
                )
//                LoginView()
//                OnboardingView()
//                ContentView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
//            SplashView()
        }
    }
}
