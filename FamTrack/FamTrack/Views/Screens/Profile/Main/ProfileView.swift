//
//  ProfileView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/21.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -25.892013, longitude: -25.892013), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        VStack {
            ZStack {
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .opacity(0.5)
                
                Ellipse()
                    .frame(maxWidth: 250, maxHeight: 250)
                    .background(Color("WhiteBlur"))
                    .opacity(0.07)
                    .blur(radius: 40)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Anton Erasmus")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(alignment: .leading){
                    HStack(spacing: 15) {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .foregroundColor(Color("Red"))
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 22)
                        
                        Text("Limpopo")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Light", size: 15))
                    }
                    
                    HStack(spacing: 15) {
                        Image(systemName: "clock")
                            .resizable()
                            .foregroundColor(Color("Red"))
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 22)
                        
                        Text("Since 06:13")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Light", size: 15))
                    }
                }
                
            }
            .padding(.horizontal, 30)
            
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text("Additional features will soon be added here")
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .border(.red)
            
            Spacer()
                .frame(height: 30)
            
            VStack {
                Text("You can view Anton's drive report as well as his health report.")
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Regular", size: 17))
            }
            .padding(.horizontal, 30)
            
            Spacer()
                .frame(height: 30)
            
            HStack {
                NavigationLink {
                    //                    ApplicationSwitcher()
                    
                } label: {
                    Text("Drive Report")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Medium", size: 15))
//                        .frame(maxWidth: true ? .infinity : 150)
//                        .frame(maxHeight: .infinity)
                        .background(Color("SecondaryDarkBlue"))
                        .cornerRadius(10)
//                        .lineLimit(1)
                }.simultaneousGesture(TapGesture().onEnded{
                    //                    isOnboardingDone = true
                    //                    userVM.showLoginView()
                    print("Show drive report")
                })
                
                Spacer()
//                    .frame(width: 15)
                
                NavigationLink {
                    //                    ApplicationSwitcher()
                    
                } label: {
                    Text("Health Report")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Medium", size: 15))
//                        .frame(maxWidth: true ? .infinity : 150)
                        .background(Color("SecondaryDarkBlue"))
                        .cornerRadius(10)
//                        .lineLimit(1)
                }.simultaneousGesture(TapGesture().onEnded{
                    //                    isOnboardingDone = true
                    //                    userVM.showSignUpView()
                    print("Show health report")
                })
                
            }
            .padding(.horizontal, 30)
            //                .frame(maxWidth: .infinity)
        }
        .frame(maxHeight: .infinity)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
