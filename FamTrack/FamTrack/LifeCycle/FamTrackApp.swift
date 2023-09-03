//
//  FamTrackApp.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/05.
//

import SwiftUI
import Firebase
import CoreLocation

@main
struct FamTrackApp: App {
    @AppStorage("onboardingDone") var isOnboardingDone: Bool = false
    @AppStorage("setupDone") var isSetupDone: Bool = false
    @StateObject var userStateViewModel = UserStateViewModel()
    @StateObject var locationManager = LocationManager()
    @StateObject var healthManager = HealthManager()
    
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
            .environmentObject(locationManager)
            .environmentObject(healthManager)
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        _ = LocationManager()
        
        var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        backgroundTask = application.beginBackgroundTask(expirationHandler: {
            application.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        })
    }
}
