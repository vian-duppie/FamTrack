//
//  MembersTabView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/01.
//

import SwiftUI
import CoreLocation

struct MembersTabView: View {
    @EnvironmentObject var userVM: UserStateViewModel
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var homeVM: HomeViewModel
    
    // Add a property to store the currently selected user
    @State private var currentlySelectedUser: User? = nil
    
    var body: some View {
        VStack {
            Text("Members")
                .foregroundColor(Color("Primary"))
                .font(Font.custom("Poppins-Medium", size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        Spacer()
            .frame(height: 20)
        
        ScrollView() {
            VStack(spacing: 15) {
                if userVM.selectedGroupUsers.count > 0 {
                    ForEach(userVM.selectedGroupUsers) { user in
                        UserCard(
                            user: user,
                            username: user.username,
                            time: user.time,
                            lastLocation: locationManager.lastKnownLocations[user.id ?? ""] ?? "Unknown",
                            onTapLocationButton: { latitude, longitude in
                                // Update the selectedUserLocation when the button is tapped
                                if let latitude = user.latitude, let longitude = user.longitude {
                                     homeVM.selectedUserLocation = CLLocationCoordinate2D(latitude: convertToDouble(latitude) ?? 0, longitude: convertToDouble(longitude) ?? 0)
                                }
                            }
                        )
                        .onAppear {
                            locationManager.fetchLastKnownLocation(for: user)
                        }
                    }
                } else {
                    Text("Please join a group or create a group in the settings tab")
                        .foregroundColor(Color("Primary"))
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        
        Spacer()
            .frame(height: 10)
        
        NavigationLink {
            InviteMemberView(groupCode: userVM.selectedGroup.inviteCode)
        } label: {
            HStack(spacing: 15) {
                Image(systemName: "plus")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .padding(15)
                    .background(Color("SecondaryDarkBlue"))
                    .clipShape(Circle())

                Text("Add New Member")
                    .foregroundColor(Color("Primary"))
                    .font(Font.custom("Poppins-Regular", size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
    }
    
    func convertToDouble(_ input: String) -> Double? {
        let cleanedString = input.replacingOccurrences(of: ",", with: ".")
        return Double(cleanedString)
    }
}
