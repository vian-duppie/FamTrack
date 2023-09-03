//
//  GroupModel.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/27.
//

import Foundation
import FirebaseFirestoreSwift
import CoreLocation

struct Group: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var name: String
    var leader: Leader?
    var members: [String]?
    var locations: [Location]?
    var inviteCode: String
    
    // Conform to Hashable by using the 'id' property for hashing
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Conform to Equatable
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Leader: Codable {
    var userId: String?
    var role: String?
}

struct Location: Codable {
    var lat: String
    var long: String
    var name: String
}
