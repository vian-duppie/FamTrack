//
//  LocationManager.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/28.
//

import MapKit
import CoreLocation
import Firebase
import FirebaseFirestore

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let db = Firestore.firestore()
    
    // Will observe for changes in the user’s location
    @Published var region = MKCoordinateRegion()
    @Published var userSpeed: Int = 0
    @Published var totalDistanceTraveled: CLLocationDistance = 0 // Added for tracking total distance
    @Published var topSpeed: Int = 0
    @Published var isDriving: Bool = false
    @Published var driveCount: Int = 0
    
    @Published var totalDistanceWalked: CLLocationDistance = 0
    @Published var lastDistanceWalked: Int = 0
    
    @Published var shouldUpdatedUserLocation: Bool = false
    
    @Published var topSpeeds: [TopSpeedEntry] = []
    
    private var previousLocation: CLLocation?
    private var user: User?
    
    private let manager = CLLocationManager()
    
    var updateLocationTimer: Timer?
    
    @Published var distanceToAdd = 0
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        // Schedule a timer to call updateUserLocation every minute
         updateLocationTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
             self?.updateUserLocation()
         }
        
        // Initialize the user property with user data
        if let userId = Auth.auth().currentUser?.uid {
            loadUserData(userId: userId)
        }
    }
    
    var lastUpdateTimeStamp: TimeInterval = 0
    var lastUpdateDistance: Int = 0
    
    private func loadUserData(userId: String) {
        let userRef = db.collection("users").document(userId)
        userRef.getDocument { [weak self] document, error in
            guard let self = self else { return }
            if let document = document, document.exists, let user = try? document.data(as: User.self) {
                self.user = user
                // Initialize topSpeeds if it's nil (first-time user)
                if self.user?.topSpeeds == nil {
                    self.user?.topSpeeds = []
                }
            }
        }
    }
    
    func setUserLocation() {
        print("Updating user location when launching app")
    }
    
    // Clean up top speeds older than 7 days and keep only the highest speed entry for each day
    func filterAndUpdateTopSpeeds(_ user: inout User, in userRef: DocumentReference) {
        // Create a dictionary to store the highest speed entry for each day
        var highestSpeedsByDate: [Date: Int] = [:]

        // Iterate through topSpeeds to find the highest speed entry for each day
        for entry in user.topSpeeds {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: entry.date)
            if let date = calendar.date(from: dateComponents) {
                if let existingSpeed = highestSpeedsByDate[date] {
                    // Compare the current entry's speed with the existing highest speed for the day
                    if entry.speed > existingSpeed {
                        highestSpeedsByDate[date] = entry.speed
                    }
                } else {
                    // If no entry exists for the day, add the current entry as the highest speed
                    highestSpeedsByDate[date] = entry.speed
                }
            }
        }

        // Filter topSpeeds to keep only the entries with the highest speeds for each day
        user.topSpeeds = user.topSpeeds.filter { entry in
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: entry.date)
            if let date = calendar.date(from: dateComponents) {
                if let highestSpeed = highestSpeedsByDate[date] {
                    return entry.speed == highestSpeed
                }
            }
            return false
        }
    }


    func updateUserLocation() {
        guard var user = user else {
            return
        }
        // Firebase only updates if it has not updated for 5 seconds to stop excessive updated
//        print("Firebase checking if it should update")
        let now = Date().timeIntervalSince1970
        // The user document will be updated because 5 seconds has passed since it has been updated and other conditions has been met to update the doc
        if now - lastUpdateTimeStamp >= 5 {
            lastUpdateTimeStamp = now

            guard let userId = Auth.auth().currentUser?.uid else {
//                print("User is not logged in")
                return
            }

            let db = Firestore.firestore()
            let userRef = db.collection("users").document(userId)

            // Check if the current speed is greater than the stored top speed
            if userSpeed > user.topSpeeds.last?.speed ?? 0 {
                // Create a new top speed entry
                let newTopSpeedEntry = TopSpeedEntry(speed: userSpeed, date: Date())
                // Append it to the user's top speeds
                user.topSpeeds.append(newTopSpeedEntry)
            }
            

            // Clean up top speeds older than 7 days
            let cutoffDate = Date().addingTimeInterval(-7 * 24 * 60 * 60) // 7 days in seconds
            user.topSpeeds = user.topSpeeds.filter { $0.date > cutoffDate }

            // Filter and update top speeds
            filterAndUpdateTopSpeeds(&user, in: userRef)

            let topSpeedsData = user.topSpeeds.map { ["speed": $0.speed, "date": $0.date] as [String : Any] }
            
//            cleanUpTopSpeeds()
            
            if isDriving {
                user.totalDistanceDriven += Double(distanceToAdd)
            }
            
            user.driveCount += driveCount

            print("Distance traveled \(lastUpdateDistance)")
            // Update the user document with the new total distance and other location data
            let locationData: [String: Any] = [
                "latitude": String(previousLocation?.coordinate.latitude ?? 0),
                "longitude": String(previousLocation?.coordinate.longitude ?? 0),
                "isDriving": isDriving,
                "topSpeeds": topSpeedsData,
                "speed": userSpeed,
                "totalDistanceDriven": user.totalDistanceDriven, // Update with the new total di§stance
                "time": Date(),
                "driveCount": user.driveCount
            ]

            userRef.updateData(locationData) { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print("Error updating user location: \(error)")
                } else {
                    print("User location updated successfully")
                    self.loadUserData(userId: userId)
                }
            }
            
//            // Update the last update distance
//            lastUpdateDistance = Int(totalDistanceTraveled)
        }
    }
    
    // The user location will update under the following circumstances
    // It moves more than 50 meters from the last reported location
    // They reached a new top speed while driving
    // If they start driving
    // If they stop driving
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        shouldUpdatedUserLocation = false
        
        if isDriving {
            if let previousLocation = previousLocation {
                // Calculate distance between previous and current location
                let distance = previousLocation.distance(from: location)
                totalDistanceTraveled += distance
//                print("Distance traveled while driving: \(Int(totalDistanceTraveled)) meters")
            }
            
            let distanceNow = Int(totalDistanceTraveled)
            if distanceNow - lastUpdateDistance > 50 {
//                print("The user traveled more than 50 meters while driving")
                distanceToAdd = distanceNow - lastUpdateDistance
                lastUpdateDistance = distanceNow
                
                
//                print("***Firebase will be updated*** Because of distance traveled while driving")
                shouldUpdatedUserLocation = true
            }
        } else {
//            print("The user is walking")
            if let previousLocation = previousLocation {
                let distance = previousLocation.distance(from: location)
                totalDistanceWalked += distance
//                print("Distance while walking: \(Int(totalDistanceWalked)) meters")
            }
            
            let distanceNow = Int(totalDistanceWalked)
            if distanceNow - lastDistanceWalked > 50 {
//                print("The user traveled more than 50 meters while walking")
                lastDistanceWalked = distanceNow
                
//                print("***Firebase will be updated*** because of the distance while walking")
                shouldUpdatedUserLocation = true
            }
        }

        // This indicates that the user is now driving (the speed is in meter per seconds)
        // 7m/s is roughly 25km/h
        if location.speed > 7 {
            let speedKmPerHour = Int(location.speed * 3.6)
//            print("User is going \(speedKmPerHour) km/h")
            userSpeed = speedKmPerHour
            
            if speedKmPerHour > topSpeed {
                print("A new topSpeed is achieved")
                topSpeed = speedKmPerHour

                // Check if there is already a top speed entry for today
                let today = Calendar.current.startOfDay(for: Date())
                
                if let existingEntryIndex = topSpeeds.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
                    // Update the existing entry if today's entry already exists
                    topSpeeds[existingEntryIndex].speed = topSpeed
                    topSpeeds[existingEntryIndex].date = today

                    // This is where you update the existing top speed entry for the day
                    shouldUpdatedUserLocation = true
                } else {
                    // Create a new top speed entry for today
                    let newTopSpeedEntry = TopSpeedEntry(speed: topSpeed, date: today)
                    topSpeeds.append(newTopSpeedEntry)

                    // This is where a new top speed entry is added to the topSpeeds array
                    shouldUpdatedUserLocation = true
                }
            }




            
            if !isDriving {
                // The user started driving
                isDriving = true
//                print("User started driving")
                
                // Update the user document in firebase
//                print("***Firebase will be updated*** because the user started driving")
                shouldUpdatedUserLocation = true
            }
        } else {
            userSpeed = 0
            if isDriving {
                // The user stopped driving
                isDriving = false
//                print("User stopped driving")
                
                userSpeed = 0
                
                // The user did another drive
                driveCount += 1
//                print("Drive count: \(driveCount)")
                
                // Update the user document in firebase
//                print("***Firebase will be updated*** because the user stopped driving")
                shouldUpdatedUserLocation = true
            }
        }
        
        if shouldUpdatedUserLocation {
//            print("((::****Firebase updating****::))")
//            updateUserLocation()
            shouldUpdatedUserLocation = false
        }
        
        // Update previousLocation for the next iteration
        previousLocation = location
        
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
        }
    }
    
    @Published var lastKnownLocations: [String: String] = [:]
    
    func convertToDouble(_ input: String) -> Double? {
        let cleanedString = input.replacingOccurrences(of: ",", with: ".")
        return Double(cleanedString)
    }
    
    func fetchLastKnownLocation(for user: User) {
        if let latitude = user.latitude, let longitude = user.longitude, let userId = user.id {
            _ = CLLocation(latitude: convertToDouble(latitude) ?? 0, longitude: convertToDouble(longitude) ?? 0)
            lookUpCurrentLocation { placemark in
                if let placemark = placemark {
                    let lastKnownLocation = placemark.subLocality ?? "Unknown"
                    DispatchQueue.main.async {
                        self.lastKnownLocations[userId] = lastKnownLocation
                    }
                }
            }
        }
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.manager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    
    func lookUpLocation(for coordinate: CLLocationCoordinate2D, completionHandler: @escaping (CLPlacemark?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()

        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?.first
                completionHandler(firstLocation)
            } else {
                // An error occurred during geocoding.
                completionHandler(nil)
            }
        }
    }

}

