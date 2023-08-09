//
//  OnboardingView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboardingDone") var isOnboardingDone: Bool = false
    @State private var currentOnboardingView = 0
    
    var views : [AnyView] = [AnyView(OnboardingOneView()), AnyView(OnboardingTwoView()), AnyView(OnboardingThreeView())]
    
    var body: some View {
        VStack {
            NavigationLink {
                AccountActionView()
                    .navigationBarHidden(true)
            } label: {
                Text("Skip")
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Medium", size: 16))
                    .frame(maxWidth: .infinity, alignment: .topTrailing)
            }

            Spacer()
            
            VStack {
                TabView(selection: $currentOnboardingView) {
                    ForEach(0 ..< views.count, id: \.self) { index in
                        views[index]
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            HStack {
                DotProgressBar(indexCount: views.count-1, currentIndex: currentOnboardingView)
                
                Spacer()
                                
                if currentOnboardingView < views.count - 1 {
                    CustomIconButton(icon: "arrow.right", action: handleNextButton)
                } else {
                    NavigationLink {
                        AccountActionView()
                    } label: {
                        Image(systemName: "arrow.right")
                             .resizable()
                             .scaledToFit()
                             .frame(maxWidth: 20)
                             .padding(20)
                             .background(Color("SecondaryDarkBlue"))
                             .clipShape(Circle())
                             .foregroundColor(.white)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func handleNextButton() {
        if currentOnboardingView < views.count - 1 {
            withAnimation(.easeInOut(duration: 1)) {
                currentOnboardingView += 1
            }
        }
    }
    
    func test() {
        print("HEY THIS HAVE BEEN PRESSED")
    }
}

struct testingView: View {
    var body: some View {
        Text("HEY WHAT ARE YOU DOIUNG")
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
