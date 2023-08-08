//
//  OnboardingView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentOnboardingView = 0
    
    var views : [AnyView] = [AnyView(OnboardingOneView()), AnyView(OnboardingTwoView()), AnyView(OnboardingThreeView())]
    
    var body: some View {
        VStack {
            Text("Skip")
                .foregroundColor(.white)
                .font(Font.custom("Poppins-Medium", size: 16))
                .frame(maxWidth: .infinity, alignment: .topTrailing)
            
            Spacer()
            
            VStack {
                TabView(selection: $currentOnboardingView) {
                    ForEach(0 ..< views.count, id: \.self) { index in
                        views[index]
                            .tag(index)
                            .transition(.scale)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
            HStack {
                DotProgressBar(indexCount: views.count-1, currentIndex: currentOnboardingView)
                
                Spacer()

                CustomIconButton(icon: "arrow.right", action: handleNextButton)
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
        } else {
            currentOnboardingView = 0
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
