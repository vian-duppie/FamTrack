//
//  SetupThreeView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/10.
//

import SwiftUI

struct SetupThreeView: View {
    @AppStorage("setupDone") var isSetupDone: Bool = false
    @EnvironmentObject var setupVM: SetupViewModel
    @State var isPlaceNameError: Bool = false
    @State var placeNameHint: String = ""
    
    var body: some View {
        VStack{
            ZStack {
                Image(systemName: "mappin.and.ellipse")
                     .resizable()
                     .scaledToFit()
                     .frame(maxWidth: 70, maxHeight: 70)
                 
                Ellipse()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .background(Color("WhiteBlur"))
                    .opacity(0.07)
                    .blur(radius: 40)
            }
            
            VStack(spacing: 15) {
                Text("Add a Place")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Add the place that the members of this group visit quite often.")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 30)
            
            CustomInput(
                label: "Place Name",
                placeholder: "What do you call this place?",
                showingError: isPlaceNameError,
                hintLabel: placeNameHint,
                value: $setupVM.placeName
            )
            .onChange(of: setupVM.placeName) { value in
                isPlaceNameError = false
                placeNameHint = ""
            }
            
            Spacer()
            
            VStack {
                Text("Address")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Medium", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 25)
                
                VStack(spacing: 5) {
                    Button(action: {
                        setupVM.currentLocationView = true
                    }) {
                        Text("Current Location")
                            .frame(minWidth: 120)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("Red"), lineWidth: 2)
                            )
                            .background(setupVM.currentLocationView ? Color("Red") : .clear)
                            .cornerRadius(10)
                            .lineLimit(1)
                    }
                    
                    Text("or")
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Light", size: 15))
                    
                    Button(action: {
                        setupVM.currentLocationView = false
                    }) {
                        Text("Type Address")
                            .frame(minWidth: 120)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 15))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("Red"), lineWidth: 2)
                            )
                            .background(setupVM.currentLocationView ? .clear : Color("Red"))
                            .cornerRadius(10)
                            .lineLimit(1)
                    }
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        setupVM.currentView += 1
                    }) {
                        Text("Continue")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 15))
                            .background(Color("SecondaryDarkBlue"))
                            .cornerRadius(10)
                            .lineLimit(1)
                    }
    //                .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Spacer()
                        .frame(height: 15)
                    
                    Button(action: {
                        withAnimation {
                            isSetupDone = true
                        }
                    }) {
                        Text("Skip")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 16))
                    }
    //                .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SetupThreeView_Previews: PreviewProvider {
    static var previews: some View {
        SetupThreeView()
    }
}
