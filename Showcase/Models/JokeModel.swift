import Foundation

struct JokeModel: Codable {
    let category: [Category]?
    let id: String
    let value: String
    let iconUrl: String
}

typealias Jokes = [JokeModel]
typealias Category = String
typealias Categories = [Category]
