import Foundation

struct Embedded: Codable {
    let embedded: Events
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct Events: Codable {
    var events: [EventModel]
}

struct EventModel: Codable {
    let name: String
    let id: String
}

struct EventCategoryModel {
    let keyword: String
}


