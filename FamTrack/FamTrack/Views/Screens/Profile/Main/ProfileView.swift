//
//  ProfileView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/21.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    @EnvironmentObject var userVM: UserStateViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var region: MKCoordinateRegion
    @State private var sublocality: String?
    
    var userData: User // Property to hold user data
    
    init(userData: User) {
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(userData.latitude ?? "0") ?? 0, longitude: Double(userData.longitude ?? "0") ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)))
        self.userData = userData
    }
    
    var lastLocationSinceFormatted: String {
        if let date = userData.time {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm MM/dd/yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: [userData]) { user in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: Double(user.latitude ?? "0") ?? 0, longitude: Double(user.longitude ?? "0") ?? 0)) {
                        PlaceAnnotationView(username: user.username, isDriving: user.isDriving, speed: user.speed)
                    }
                }
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                
                Ellipse()
                    .frame(maxWidth: 250, maxHeight: 250)
                    .background(Color("WhiteBlur"))
                    .opacity(0.07)
                    .blur(radius: 40)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(userData.username)
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
                        
                        Text(sublocality ?? "Unknown Location")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Light", size: 15))
                    }
                    
                    HStack(spacing: 15) {
                        Image(systemName: "clock")
                            .resizable()
                            .foregroundColor(Color("Red"))
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 22)
                        
                        Text("Since \(lastLocationSinceFormatted)")
                            .foregroundColor(.white)
                            .font(Font.custom("Poppins-Light", size: 15))
                    }
                }
                
            }
            .padding(.horizontal, 30)
            
            Spacer()
                .frame(height: 30)
            
            VStack {
                Text("You can view \(userData.username)'s drive report as well as their health report.")
                    .foregroundColor(.white)
                    .font(Font.custom("Poppins-Regular", size: 17))
            }
            .padding(.horizontal, 30)
            
            Spacer()
                .frame(height: 30)
            
            HStack {
                NavigationLink {
                    DriveReportView(userData: userData)
                } label: {
                    Text("Drive Report")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Medium", size: 15))
                        .background(Color("SecondaryDarkBlue"))
                        .cornerRadius(10)
                }
                
                Spacer()
                
                NavigationLink {
                    HealthReportView(userData: userData)
                } label: {
                    Text("Health Report")
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .font(Font.custom("Poppins-Medium", size: 15))
                        .background(Color("SecondaryDarkBlue"))
                        .cornerRadius(10)
                }
                
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            let customCoordinates = CLLocationCoordinate2D(latitude: Double(userData.latitude ?? "0") ?? 0, longitude: Double(userData.longitude ?? "0") ?? 0)
            
            locationManager.lookUpLocation(for: customCoordinates) { placemark in
                if let placemark = placemark {
                    sublocality = placemark.subLocality
                }
            }
        }
    }
}
