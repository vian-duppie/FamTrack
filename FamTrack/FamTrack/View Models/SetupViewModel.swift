//
//  SetupViewModel.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/27.
//

import Foundation
import CryptoKit
import Firebase
import FirebaseFirestoreSwift

class SetupViewModel: ObservableObject {
    // Firestore
    private var db = Firestore.firestore()
    
    // SetupView that the user is on
    @Published var currentView: Int = 0
    @Published var isBusy: Bool = false
    
    @Published var selectedRole: String = "Leader"
    @Published var groupName: String = ""
    @Published var placeName: String = ""
    
    // Future Implementation to be done
    @Published var currentLocationView: Bool = false
    
    func generateUniqueCode(placeName: String, groupName: String, userId: String) -> String {
        let inputString = "\(placeName)\(groupName)\(userId)"
        
        if let inputData = inputString.data(using: .utf8) {
            let hashedData = SHA256.hash(data: inputData)
            let codeData = hashedData.prefix(6)
            
            print(codeData)
            let code = codeData.map{String(format: "%02hhx", $0)}.joined()
            return String(code.prefix(6)).uppercased()
        }
        
        return String(userId.prefix(6))
    }
    
    func createGroup(userId: String, currentUserLat: Double, currentUserLong: Double, completion: @escaping (Bool) -> Void) {
        let leaderData = Leader(userId: userId, role: selectedRole)
        let locationData = Location(lat: Double(currentUserLat), long: Double(currentUserLong), name: placeName)
        let inviteCode = generateUniqueCode(placeName: placeName, groupName: groupName, userId: userId)
        
        let locationDictionary: [String: Any] = [
            "lat": locationData.lat,
            "long": locationData.long,
            "name": locationData.name
        ]
        
        let memberDictionary: [String: Any] = [
            "userId": userId
        ]
        
        let groupData: [String: Any] = [
            "name": groupName,
            "leader": [
                "userId": leaderData.userId ?? "",
                "role": leaderData.role ?? ""
            ],
            "locations": [locationDictionary],
            "inviteCode": inviteCode,
            "members": [memberDictionary]
        ]
        
        let docRef = db.collection("Groups").document()
        docRef.setData(groupData) {err in
            if let err = err {
                print(err)
                completion(false)
            } else {
                print(docRef.documentID)
                completion(true)
            }
        }
        
        
    }
}


