//
//  HomeView.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/17.
//

import SwiftUI
import MapKit

struct PlaceAnnotationView: View {
    var username: String
    var isDriving: Bool
    var speed: Int
    
    var body: some View {
        VStack {
            Text(username.prefix(1))
                .frame(width: 30, height: 30)
                .foregroundColor(Color("TextWhite"))
                .background(Color("Red"))
                .clipShape(Circle())
            
            if isDriving {
                Text("\(speed) km/h")
                    .foregroundColor(Color("TextWhite"))
                    .background(Color("Red"))
            }
        }
        
    }
}

struct HomeView: View {
    // Variable to store whether the user has completed or skipped the setup
    @AppStorage("setupDone") var isSetupDone: Bool = false
    
    @EnvironmentObject var userVM: UserStateViewModel
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var healthManager: HealthManager
    @StateObject var homeVM = HomeViewModel()
    
    let screenHeight = UIScreen.main.bounds.size.width
    @State var tabViewToShow = 0
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -22.892013, longitude: -23.892013), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @State var onSelect: (Group) -> Void = { _ in }
    
    //    @State private var selectedUserLocation: CLLocationCoordinate2D? = nil {
    //        didSet {
    //            region.center = selectedUserLocation ?? CLLocationCoordinate2D(latitude: -22.892013, longitude: -23.892013)
    //            // You may also want to adjust the span accordingly here
    //        }
    //    }
    @State private var shouldCenterMap = true
    
    var body: some View {
        GeometryReader {proxy in
            VStack {
                ZStack(alignment: .top) {
                    Map(
                        coordinateRegion: Binding(
                            get: {
                                // Check if the map should be centered initially
                                if let selectedLocation = homeVM.selectedUserLocation {
                                    return MKCoordinateRegion(center: selectedLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                                } else {
                                    return region
                                }
                            },
                            set: { _ in }
                        ),
                        userTrackingMode: .none,
                        annotationItems: userVM.selectedGroupUsers
                    ) { user in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: convertToDouble(user.latitude ?? "0") ?? 0, longitude: convertToDouble(user.longitude ?? "0") ?? 0)) {
                            PlaceAnnotationView(username: user.username, isDriving: user.isDriving, speed: user.speed)
                        }
                    }
                    
                    VStack {
                        Spacer()
                            .frame(height: proxy.safeAreaInsets.top + 5)
                        
                        DropdownButton(displayText: .constant(userVM.selectedGroup.name), options: userVM.options, onSelect: onSelect)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: screenHeight)
                
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                tabViewToShow = 0
                            }
                        }) {
                            Image(systemName: "person.3.fill")
                                .foregroundColor(tabViewToShow == 0 ? Color("LightBlue") : .white)
                                .padding(.vertical, 10)
                                .frame(minWidth: 85)
                                .background(Color("Primary"))
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        //                        Button(action: {
                        //                            withAnimation {
                        //                                tabViewToShow = 1
                        //                            }
                        //                        }) {
                        //                            Image(systemName: "mappin.and.ellipse")
                        //                                .foregroundColor(tabViewToShow == 1 ? Color("LightBlue") : .white)
                        //                                .padding(.vertical, 10)
                        //                                .frame(minWidth: 85)
                        //                                .background(Color("Primary"))
                        //                                .cornerRadius(10)
                        //                        }
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                tabViewToShow = 2
                            }
                        }) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(tabViewToShow == 2 ? Color("LightBlue") : .white)
                                .padding(.vertical, 10)
                                .frame(minWidth: 85)
                                .background(Color("Primary"))
                                .cornerRadius(10)
                        }
                    }
                    
                    //                    Text("This is your speed \(String(locationManager.userSpeed)) km/h")
                    //                        .foregroundColor(.black)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    // *** The tabviews will all be showcase here *** \\
                    if tabViewToShow == 0 {
                        MembersTabView()
                            .transition(.scale)
                            .environmentObject(homeVM)
                        //                    } else if tabViewToShow == 1 {
                        //                        LocationsTabView()
                        //                            .transition(.scale)
                    } else if tabViewToShow == 2 {
                        VStack {
                            NavigationLink {
                                InviteMemberView(groupCode: userVM.selectedGroup.inviteCode)
                            } label: {
                                Text("Invite Members")
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.white)
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .frame(maxWidth: true ? .infinity : 150)
                                    .background(Color("SecondaryDarkBlue"))
                                    .cornerRadius(10)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                                .frame(height: 20)
                            
                            NavigationLink {
                                JoinGroupView()
                            } label: {
                                Text("Join Group")
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.white)
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .frame(maxWidth: true ? .infinity : 150)
                                    .background(Color("SecondaryDarkBlue"))
                                    .cornerRadius(10)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                                .frame(height: 50)
                            
                            Button{
                                Task {
                                    await userVM.signOut()
                                }
                            } label: {
                                Text("Logout")
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.white)
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .frame(maxWidth: true ? .infinity : 150)
                                    .background(Color("SecondaryDarkBlue"))
                                    .cornerRadius(10)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .padding(.top, 15)
                .padding(.horizontal, 30)
                .padding(.bottom, proxy.safeAreaInsets.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .ignoresSafeArea()
            .onAppear {
                // Get details of current logged in user
                userVM.getUserDetails()
                locationManager.updateUserLocation()
                healthManager.updateFirebaseDocument()
                locationManager.testing()
                
                Task {
                    // Await for UserGroup to populate and then populate selected group
                    await userVM.getUserGroups()
                    
                    // Let the first group of userGroups be selected
                    if let firstGroup = userVM.userGroups.first {
                        userVM.selectedGroup = firstGroup
                        userVM.fetchUsersInGroup(group: firstGroup)
                        
                        // Center the map on the logged-in user's location
                        let loggedInUser = userVM.userDetails
                        region.center = CLLocationCoordinate2D(latitude: convertToDouble(loggedInUser.latitude ?? "0") ?? 0, longitude: convertToDouble(loggedInUser.longitude ?? "0") ?? 0)
                    }
                }
                
                onSelect = { group in
                    // Do not do anything if the same group is selected
                    if group == userVM.selectedGroup {
                        return
                    }
                    
                    // Fetch the users in the group that is selected and update selected group
                    userVM.fetchUsersInGroup(group: group)
                    userVM.selectedGroup = group
                }
            }
            .onDisappear {
                userVM.reset()
            }
        }
        .background(Color("primary"))
    }
    
    func convertToDouble(_ input: String) -> Double? {
        let cleanedString = input.replacingOccurrences(of: ",", with: ".")
        return Double(cleanedString)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RounderCorner(radius: radius, corners: corners))
    }
}

struct RounderCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
