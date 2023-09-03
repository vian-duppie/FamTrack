//
//  HealthReportView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/24.
//

import SwiftUI

struct HealthReportView: View {
    var userData: User
    
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
        ScrollView {
            ZStack {
                Image(systemName: "list.bullet.clipboard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100)
                
                Ellipse()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .background(Color("WhiteBlur"))
                    .opacity(0.07)
                    .blur(radius: 40)
            }
            .frame(maxWidth: .infinity, minHeight: 150)
            
            VStack(spacing: 5) {
                Text("Health Report")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("You can view \(userData.username)'s health summary from \(lastLocationSinceFormatted) below")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 25)
            
            Text("Activity")
                .foregroundColor(Color("TextWhite"))
                .font(Font.custom("Poppins-Regular", size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(String(format: "%.0f", userData.activeEnergy ?? 0))
                            .foregroundColor(Color("Red"))
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .frame(alignment: .leading)
                        
                        Text("kcal")
                            .foregroundColor(Color("Red"))
                            .font(Font.custom("Poppins-Medium", size: 12))
                            .frame(alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Text("Move")
                        .foregroundColor(Color("Red"))
                        .font(Font.custom("Poppins-Medium", size: 13))
                        .frame(alignment: .leading)
                }
                .frame(minWidth: 90, minHeight: 50)
                .padding(.vertical, 15)
                .padding(.horizontal, 8)
                .background(Color("CardBlueBackground"))
                .cornerRadius(8)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(String(format: "%.0f", userData.exerciseTime ?? 0))
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .frame(alignment: .leading)
                        
                        Text("min")
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 12))
                            .frame(alignment: .leading)
                    }
                    
                    
                    Spacer()
                    
                    Text("Exercise")
                        .foregroundColor(Color("SecondaryDarkBlue"))
                        .font(Font.custom("Poppins-Medium", size: 13))
                        .frame(alignment: .leading)
                }
                .frame(minWidth: 90, minHeight: 50)
                .padding(.vertical, 15)
                .padding(.horizontal, 8)
                .background(Color("CardBlueBackground"))
                .cornerRadius(8)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(String(format: "%.0f", userData.standTime ?? 0))
                            .foregroundColor(Color("TextWhite"))
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .frame(alignment: .leading)
                        
                        Text("min")
                            .foregroundColor(Color("TextWhite"))
                            .font(Font.custom("Poppins-Medium", size: 12))
                            .frame(alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Text("Stand")
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Medium", size: 13))
                        .frame(alignment: .leading)
                }
                .frame(minWidth: 80, minHeight: 50)
                .padding(.vertical, 15)
                .padding(.horizontal, 8)
                .background(Color("CardBlueBackground"))
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
                .frame(height: 25)
            
            Text("Heart")
                .foregroundColor(Color("TextWhite"))
                .font(Font.custom("Poppins-Regular", size: 17))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(String(format: "%.0f", userData.hr ?? 0))
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .frame(alignment: .leading)
                        
                        Text("BPM")
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 12))
                            .frame(alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Text("Heart Rate")
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Medium", size: 13))
                        .frame(alignment: .leading)
                }
                .frame(minWidth: 90, minHeight: 50)
                .padding(.vertical, 15)
                .padding(.horizontal, 8)
                .background(Color("CardBlueBackground"))
                .cornerRadius(8)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(String(format: "%.0f", userData.restinghr ?? 0))
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .frame(alignment: .leading)
                        
                        Text("BPM")
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 12))
                            .frame(alignment: .leading)
                    }
                    
                    
                    Spacer()
                    
                    Text("Resting")
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Medium", size: 13))
                        .frame(alignment: .leading)
                }
                .frame(minWidth: 90, minHeight: 50)
                .padding(.vertical, 15)
                .padding(.horizontal, 8)
                .background(Color("CardBlueBackground"))
                .cornerRadius(8)
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(String(format: "%.0f", userData.walkinghr ?? 0))
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .frame(alignment: .leading)
                        
                        Text("BPM")
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 12))
                            .frame(alignment: .leading)
                    }
                    
                    Spacer()
                    
                    Text("Walking")
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Medium", size: 13))
                        .frame(alignment: .leading)
                }
                .frame(minWidth: 80, minHeight: 50)
                .padding(.vertical, 15)
                .padding(.horizontal, 8)
                .background(Color("CardBlueBackground"))
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 30)
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .background(Color("Primary"))
    }
}
