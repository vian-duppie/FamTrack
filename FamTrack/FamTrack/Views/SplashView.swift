//
//  SplashView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/05.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    Text("FamTrack")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 60))
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.primary)
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
