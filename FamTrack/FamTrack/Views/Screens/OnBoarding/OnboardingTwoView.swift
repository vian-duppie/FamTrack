//
//  OnBoardingTwoView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct OnboardingTwoView: View {
    var body: some View {
        VStack {
            OnboardingLayout(
                image: "location.viewfinder",
                heading: "Track & Share Locations",
                descriptionOne: "FamTrack allows you to share real time locations with group members on a private map.",
                descriptionTwo: "Members can also create places and receive notifications when members leave or arrive at these places."
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct OnboardingTwoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTwoView()
    }
}
