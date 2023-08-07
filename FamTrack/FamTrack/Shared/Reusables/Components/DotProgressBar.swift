//
//  DotProgressBar.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/07.
//

import SwiftUI

struct DotProgressBar: View {
    var indexCount = 0
    var currentIndex = 0
    @State var dotWidth: CGFloat = 6
    
    var body: some View {
        ForEach(0...indexCount, id: \.self) {idx in
            Rectangle()
                .frame(width: currentIndex == idx ? dotWidth : 6, height: 6)
                .background(.white)
                .opacity(currentIndex == idx ? 1 : 0.1)
                .cornerRadius(5)
        }
        .onAppear {
            animateDots()
        }
        .onChange(of: currentIndex) {_ in
            dotWidth = 6
            animateDots()
        }
    }
    
    private func animateDots() {
        let baseAnimation = Animation.easeInOut(duration: 1)
        
        withAnimation(baseAnimation.delay(0.01)) {
            dotWidth = 18
        }
    }
}

struct DotProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        DotProgressBar()
    }
}
