import Foundation

struct Embedded: Codable {
    let embedded: Events
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct Events: Codable {
    let venues: [VenueModel]
    
}

struct EventModel: Codable {
    let name: String
}


