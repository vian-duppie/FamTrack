//
//  DropdownButton.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/17.
//

import SwiftUI

struct DropdownButton: View {
    @State var isDroppedDown = false
    @Binding var displayText: String
    var options: [DropdownOption]
    var onSelect: ((_ key: String) -> Void)?
    var body: some View {
        Button(action: {
            withAnimation(Animation.easeInOut(duration: 1)) {
                isDroppedDown.toggle()
            }
        }) {
            HStack(alignment: .center){
                Text(displayText)
                    .foregroundColor(Color("Primary"))
                    .frame(maxWidth: .infinity)
                
                Spacer()
                    .frame(maxWidth: .infinity)
                
                Image(systemName: isDroppedDown ? "chevron.up" : "chevron.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 10)
            }
            .frame(maxWidth: 200, minHeight: 40)
        }
        .padding(.horizontal)
        .background(.white)
        .cornerRadius(10)
        .overlay(
            VStack {
                if isDroppedDown {
                    Spacer()
                        .frame(minHeight: 50)
                    
                    Dropdown(options: options, onSelect: onSelect)
                }
            }.scaleEffect(isDroppedDown ? 1 : 0)
            , alignment: .topLeading
            
        )
    }
}

struct DropdownOption: Hashable {
    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
    
    var key: String
    var val: String
}

struct DropdownOptionElement: View {
    var val: String
    var key: String
    var onSelect: ((_ key: String) -> Void)?
    
    var body: some View {
        Button(action: {
            if let onSelect = onSelect {
                onSelect(self.key)
            }
        }) {
            Text(val)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var onSelect: ((_ key: String) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(options, id: \.self) {option in
                DropdownOptionElement(val: option.val, key: option.key, onSelect: onSelect)
            }
        }
        .background(.white)
        .cornerRadius(10)
    }
}

