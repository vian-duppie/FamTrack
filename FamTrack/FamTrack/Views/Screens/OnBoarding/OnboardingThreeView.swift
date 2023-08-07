//
//  OnboardingThreeView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct OnboardingThreeView: View {
    var body: some View {
        VStack {
            OnboardingLayout(
                image: "doc",
                heading: "View Drive & Health Reports",
                descriptionOne: "View detailed driver reports, including route history, top speeds and more of all group members.",
                descriptionTwo: "Health reports are also available in case of emergency."
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct OnboardingThreeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingThreeView()
    }
}
