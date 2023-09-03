import Foundation
import FirebaseFirestoreSwift
import CoreLocation

struct User: Identifiable, Codable, Equatable, Hashable {
    @DocumentID var id: String?
    var email: String = ""
    var username: String = ""
    var latitude: String?
    var longitude: String?
    var time: Date?
    var isDriving: Bool = false
    var speed: Int = 0
    var topSpeeds: [TopSpeedEntry] = []
    var totalDistanceDriven: Double = 0
    var driveCount: Int = 0
    
    // Health Data Fields
    var activeEnergy: Double? = 0
    var exerciseTime: Double? = 0
    var standTime: Double? = 0
    var hr: Double? = 0
    var restinghr: Double? = 0
    var walkinghr: Double? = 0
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct TopSpeedEntry: Codable, Identifiable {
    // The id will only be used when decoding data from firebase
    var id: String?
    var speed: Int
    var date: Date
    
    // This is the keys that will be Encoded and Decoded
    enum CodingKeys: String, CodingKey {
        case speed, date
    }
    
    // Initialises these values - Creates instance
    init(speed: Int, date: Date) {
        self.speed = speed
        self.date = date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try container.decode(Int.self, forKey: .speed)
        date = try container.decode(Date.self, forKey: .date)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(speed, forKey: .speed)
        try container.encode(date, forKey: .date)
    }
}
