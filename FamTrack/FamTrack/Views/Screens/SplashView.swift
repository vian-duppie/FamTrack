//
//  SplashView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/05.
//

import SwiftUI

struct SplashView<Content: View>: View {
    // Is the SplashView Done
    @State var isActive: Bool = false
    @ViewBuilder var mainView: Content
    
    // Should it show onboarding
    @AppStorage("onboardingDone") var isOnboardingDone: Bool = false
    var body: some View {
        ZStack {
            if self.isActive {
                mainView
            } else {
                ZStack {
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                        Text("FamTrack")
                            .padding(10)
                            .font(.system(size: 500))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(10)
                    .frame(maxWidth: 250, maxHeight: .infinity)
                    
                    Ellipse()
                        .frame(maxWidth: 250, maxHeight: 250)
                        .background(Color("WhiteBlur"))
                        .opacity(0.07)
                        .blur(radius: 70)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color("Primary"))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
