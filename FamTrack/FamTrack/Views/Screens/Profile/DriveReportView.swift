//
//  DriveReportView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/24.
//

import Charts
import SwiftUI

struct DriveReportView: View {
    var userData: User
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(systemName: "car.fill")
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
                Text("Drive Report")
                    .foregroundColor(Color("SecondaryDarkBlue"))
                    .font(Font.custom("Poppins-Medium", size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("You can view \(userData.username)'s driving summary below")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 25)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(String(format: "%.1f", userData.totalDistanceDriven/1000))
                        .foregroundColor(Color("SecondaryDarkBlue"))
                        .font(Font.custom("Poppins-Medium", size: 20))
                        .frame(alignment: .leading)
                    
                    Spacer()
                    
                    Text("Total KM's")
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
                        Text(String(userData.topSpeeds.last?.speed ?? 0))
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 20))
                            .frame(alignment: .leading)
                        
                        Text("km/h")
                            .foregroundColor(Color("SecondaryDarkBlue"))
                            .font(Font.custom("Poppins-Medium", size: 12))
                            .frame(alignment: .leading)
                    }
                    
                    
                    Spacer()
                    
                    Text("Top Speed")
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
                    Text(String(userData.driveCount))
                        .foregroundColor(Color("SecondaryDarkBlue"))
                        .font(Font.custom("Poppins-Medium", size: 20))
                        .frame(alignment: .leading)
                    
                    Spacer()
                    
                    Text("Total Drives")
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
            
            VStack {
                AccordionChartItem(topSpeedData: userData.topSpeeds)
            }
        }
        .padding(.horizontal, 30)
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
        .background(Color("Primary"))
    }
}

struct AccordionChartItem: View {
    @State var showChart: Bool = false
    var topSpeedData: [TopSpeedEntry] // Pass the topSpeedData
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    showChart.toggle()
                }
            }) {
                HStack {
                    Text("Top Speeds") // Modify the title
                        .foregroundColor(Color("TextWhite"))
                        .font(Font.custom("Poppins-Regular", size: 17))
                        .frame(alignment: .leading)
                    
                    Spacer()
                    
                    Image(systemName: showChart ? "chevron.up" : "chevron.right")
                        .foregroundColor(.red)
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
                .frame(height: 15)
            
            if showChart {
                VStack {
                    if topSpeedData.count > 0 {
                        Text(String(topSpeedData.count))
                            .foregroundColor(Color("Red"))
                            .font(Font.custom("Poppins-SemiBold", size: 17))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    
                    Spacer()
                        .frame(height: 5)
                    
                    // Modify the chart to use topSpeedData
                    if topSpeedData.count > 0 {
                        Chart(topSpeedData) {
                            let speed = Float($0.speed)
                            BarMark(
                                x: .value("Date", $0.date, unit: .day), // Display date
                                y: .value("Speed", $0.speed)
                            )
                            .cornerRadius(10)
                            .interpolationMethod(.cardinal)
                            .foregroundStyle(Color("Red"))
                            .annotation(position: .automatic, alignment: .topLeading, spacing: 3) {
                                Text("\(speed, specifier: "%.0F")")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                            }
                        }
                        .chartYAxis(.hidden)
                        .chartXAxis {
                            AxisMarks(values: .automatic) { value in
                                AxisGridLine().foregroundStyle(.orange)
                                AxisValueLabel(format: .dateTime.weekday(), centered: true)
                            }
                        }
                    } else {
                        Text("There is no speed data")
                            .foregroundColor(Color("Red"))
                            .font(Font.custom("Poppins-SemiBold", size: 17))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .transition(.slide)
                
                Spacer()
                    .frame(minHeight: 25)
            }
        }
    }
}

