//
//  SetupFourView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/28.
//

import SwiftUI
import MapKit

struct SetupFourView: View {
    @AppStorage("setupDone") var isSetupDone: Bool = false
    @EnvironmentObject var userVM: UserStateViewModel
    @EnvironmentObject var setupVM: SetupViewModel
    @State var isPlaceNameError = false
    @State var placeNameHint = ""
    
    @StateObject var manager = LocationManager()
    
    @State private var currentPlacemark: CLPlacemark?
    @State var placemarkError = false
    
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ScrollView {
            VStack {
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
                        .fixedSize(horizontal: false, vertical: true)
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
                    .frame(height: 20)
                
                VStack(spacing: 20) {
                    Text("Current Location")
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Medium", size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Map(coordinateRegion: $manager.region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                            .frame(width: screenWidth * 0.7, height: screenWidth * 0.7)
                            .clipShape(Circle())
                            .opacity(0.5)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Spacer()
                    .frame(height: 30)
                
                VStack {
                    Button(action: {
                        createGroup()
                    }) {
                        Text("Add Place")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Medium", size: 15))
                            .background(Color("SecondaryDarkBlue"))
                            .cornerRadius(10)
                            .lineLimit(1)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicators(.hidden)
    }
    
    func createGroup() {
        isPlaceNameError = false
        placeNameHint = ""
        
        if setupVM.placeName.isEmpty {
            isPlaceNameError = true
            placeNameHint = "Please enter the name of the place"
            return
        }
        
        setupVM.createGroup(userId: userVM.getUserId(), currentUserLat: manager.region.center.latitude, currentUserLong: manager.region.center.longitude) { success in
            if success {
                print("Doc was created")
                isSetupDone = true
            } else {
                print("Doc was not created")
            }
        }
    }
}

struct SetupFourView_Previews: PreviewProvider {
    static var previews: some View {
        SetupFourView()
    }
}
