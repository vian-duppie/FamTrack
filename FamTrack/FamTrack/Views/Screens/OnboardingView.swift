//
//  OnboardingView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct OnboardingView: View {
    @State var currentOnboardingView = 0
    @State var viewWidth: CGFloat = 0
    @State var isAnimating = false
    var views : [AnyView] = [AnyView(OnboardingOneView()), AnyView(OnboardingTwoView()), AnyView(OnboardingThreeView())]
    
    var body: some View {
        VStack { // VStack Outer
            Text("Skip")
                .foregroundColor(.white)
                .font(Font.custom("Poppins-Medium", size: 16))
                .frame(maxWidth: .infinity, alignment: .topTrailing)
            
            Spacer()
            
            VStack {
                views[currentOnboardingView]
                    .frame(maxWidth: isAnimating ? .infinity : .infinity, alignment: .center)
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut, value: isAnimating)
//                    .onChange(of: currentOnboardingView) {_ in
//                        isAnimating = true
//                        let baseAnimation = Animation.easeInOut(duration: 1)
//
//                        withAnimation(baseAnimation) {
//                            isAnimating = false
//                        }
//                    }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            

            
            Spacer()
            
            HStack {
                DotProgressBar(indexCount: 2, currentIndex: currentOnboardingView)
                
                Spacer()
                
                Button("Test") {
                    if currentOnboardingView < views.count - 1 {
//                        currentOnboardingView += 1
                        withAnimation {
                            isAnimating.toggle()
                        }
                        isAnimating.toggle()
                        print(views.count)
                        print(currentOnboardingView)
                    } else {
                        currentOnboardingView = 0
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //VStack Outer
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
