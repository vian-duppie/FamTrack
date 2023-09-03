//
//  UserCard.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/01.
//

import SwiftUI
import CoreLocation

struct UserCard: View {
    @EnvironmentObject var userVM: UserStateViewModel
    var user: User
    var username: String
    var time: Date?
    var lastLocation: String
    
    var lastLocationSinceFormatted: String {
        if let date = time {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm MM/dd/yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
    
    var onTapLocationButton: (Double, Double) -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            NavigationLink {
                ProfileView(userData: user)
            } label: {
                Text(username.prefix(1))
                    .foregroundColor(Color("TextWhite"))
                    .frame(maxWidth: 55, maxHeight: 55)
                    .background(Color("Red"))
                    .clipShape(Circle())
            }
            .environmentObject(userVM)

            
            Spacer()
                .frame(width: 15)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(username)
                    .foregroundColor(Color("Primary"))
                    .font(Font.custom("Poppins-Regular", size: 15))
                
                HStack(spacing: 15) {
                    Image(systemName: "clock")
                        .resizable()
                        .foregroundColor(Color("Primary"))
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 10)
                    
                    Text("Since \(lastLocationSinceFormatted)")
                        .foregroundColor(Color("Primary"))
                        .font(Font.custom("Poppins-Light", size: 13))
                }
            }
            
            Spacer()
            
            Button(action: {
                if let latitude = user.latitude, let longitude = user.longitude {
                    onTapLocationButton(convertToDouble(latitude) ?? 0, convertToDouble(longitude) ?? 0)
                }
            }) {
                Image(systemName: "location")
                    .resizable()
                    .foregroundColor(Color("LightBlue"))
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 20, maxHeight: 20)
            }
        }
    }
    
    func convertToDouble(_ input: String) -> Double? {
        let cleanedString = input.replacingOccurrences(of: ",", with: ".")
        return Double(cleanedString)
    }
}
