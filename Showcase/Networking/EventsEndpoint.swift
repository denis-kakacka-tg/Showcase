import Foundation
import Moya

// Moya ppci framework pre abstrakciu network layeru, precitajte si viac o nom na Githube

enum EventRequests {
    case suggest
    case eventsFor(keyword: String)
}

extension EventRequests: TargetType {
    var baseURL: URL {
        return URL(string: "https://app.ticketmaster.com/discovery/v2")!
    }
    
    var path: String {
        switch self {
        case .suggest:
            return "/suggest"
        case .eventsFor:
            return "/events"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .suggest:
            return .requestParameters(parameters: ["apikey" : "p4cG2rqAq8tZadAmLeGGucL81GHd2djA"], encoding: URLEncoding.default)
        case .eventsFor(let keyword):
            return .requestParameters(parameters: ["apikey" : "p4cG2rqAq8tZadAmLeGGucL81GHd2djA", "keyword" : keyword], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
