//
//  SetupFourView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/28.
//

import SwiftUI
import MapKit

struct SetupFourView: View {
    @State var triggerViewUpdate = 0
    
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
                    .frame(height: 25)
                
//                HStack(spacing: 10) {
//                    Image(systemName: "dot.circle")
//                        .resizable()
//                        .foregroundColor(Color("Red"))
//                        .frame(width: 20, height: 20)
//                    
//                    VStack(spacing: 5) {
//                        Text("Your Current Location")
//                            .foregroundColor(Color("TextWhite"))
//                            .font(Font.custom("Poppins-Light", size: 15))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        Text(
//                            placemarkError ?
//                            "\(currentPlacemark?.name ?? "") \(currentPlacemark?.subLocality ?? ""), \(currentPlacemark?.locality ?? "")" : "Could not find location name"
//                        )
//                            .foregroundColor(Color("TextGray"))
//                            .font(Font.custom("Poppins-Light", size: 14))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                }
                
                Spacer()
                    .frame(height: 30)
                
                VStack {
                    Button(action: {
                        setupVM.currentView += 1
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
//        .onChange(of: manager.region.center.latitude) { _ in
//            placemarkError = false
//
//            manager.lookUpCurrentLocation { (placemark) in
//                if let placemark = placemark {
//                    self.currentPlacemark = placemark
//                } else {
//                    placemarkError = true
//                    print("Error fetching current location.")
//                }
//            }
//        }
//        .onAppear {
//            manager.lookUpCurrentLocation { (placemark) in
//                if let placemark = placemark {
//                    self.currentPlacemark = placemark
//                    print("You live here",  placemark.country)
//                    print("1", placemark.areasOfInterest)
//                    print("2",placemark.administrativeArea)
//                    print("3",placemark.inlandWater)
//                    print("4",placemark.isoCountryCode)
//                    print("5",placemark.locality)
//                    print("6",placemark.location)
//                    print("7",placemark.name)
//                    print("8",placemark.postalCode)
//                    print("9", placemark.region)
//                    print("10", placemark.subAdministrativeArea)
//                    print("11", placemark.subLocality)
//                    print("12", placemark.thoroughfare)
//                    print("13", placemark.timeZone)
//
//                    print(placemark.name, " ", placemark.subLocality, ", ", placemark.locality)
//                } else {
//                    print("Error fetching current location.")
//                }
//            }
//        }
//        .scrollBounceBehavior(.basedOnSize)
        .scrollIndicators(.hidden)
        
    }
}

struct SetupFourView_Previews: PreviewProvider {
    static var previews: some View {
        SetupFourView()
    }
}
