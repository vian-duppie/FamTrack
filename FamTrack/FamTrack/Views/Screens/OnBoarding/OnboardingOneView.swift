//
//  OnBoardingOneView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct OnboardingOneView: View {
    var body: some View {
        VStack {
            OnboardingLayout(
                image: "person.3",
                heading: "Create Groups",
                descriptionOne: "Create different groups for different sets of people like family, friends, work etc.",
                descriptionTwo: "Each group can have its own set of location sharing settings."
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct OnboardingOneView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingOneView()
    }
}
