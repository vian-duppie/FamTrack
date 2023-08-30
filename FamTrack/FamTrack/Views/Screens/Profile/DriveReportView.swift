//
//  DriveReportView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/24.
//

import Charts
import SwiftUI

struct DriveReportView: View {
    let currentWeek: [StepCount] = [
        StepCount(day: "20220717", steps: 5),
        StepCount(day: "20220718", steps: 0),
        StepCount(day: "20220719", steps: 2),
        StepCount(day: "20220720", steps: 0),
        StepCount(day: "20220721", steps: 2),
        StepCount(day: "20220722", steps: 1),
        StepCount(day: "20220723", steps: 5)
    ]
    
    @State var showHighSpeed: Bool = false
    @State var showChart: Bool = false
    @State var test: Bool = false
    
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
                
                Text("You can view Anton's driving summary below")
                    .foregroundColor(Color("TextWhite"))
                    .font(Font.custom("Poppins-Regular", size: 17))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 25)
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("200")
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
                        Text("120")
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
                    Text("3")
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
                AccordionChartItem(currentWeek: currentWeek)
                
                AccordionChartItem(currentWeek: currentWeek)
                
                AccordionChartItem(currentWeek: currentWeek)
                
                AccordionChartItem(currentWeek: currentWeek)
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
    var currentWeek: [StepCount]
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    showChart.toggle()
                }
            }
            ){
                HStack {
                    Text("Phone Usage")
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
                    Text("10")
                        .foregroundColor(Color("Red"))
                        .font(Font.custom("Poppins-SemiBold", size: 17))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Spacer()
                        .frame(height: 5)
                    
                    Chart(currentWeek) {
                        let step = Float($0.steps)
                        BarMark(
                            x: .value("Week Day", $0.weekday, unit: .day),
                            y: .value("Step Count", $0.steps)
                        )
                        .cornerRadius(10)
                        .interpolationMethod(.cardinal)
                        .foregroundStyle(Color("Red"))
                        .annotation(position: .automatic, alignment: .topLeading, spacing: 3) {
                            Text("\(step, specifier: "%.0F")")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                    .chartYAxis(.hidden)
                    .chartXAxis {
                        AxisMarks (values: .stride (by: .day)) { value in
                            AxisGridLine().foregroundStyle(.orange)
                            AxisValueLabel(format: .dateTime.weekday(),
                                           centered: true)
                        }
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

struct DriveReportView_Previews: PreviewProvider {
    static var previews: some View {
        DriveReportView()
    }
}

struct StepCount: Identifiable {
    let id = UUID()
    let weekday: Date
    let steps: Int
    
    init(day: String, steps: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        self.weekday = formatter.date(from: day) ?? Date.distantPast
        self.steps = steps
    }
    
    var weekdayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: weekday)
    }
}
