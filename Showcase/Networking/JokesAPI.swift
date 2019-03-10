import Foundation
import Moya

enum JokesRequest {
    case random
    case categories
    case randomInCategory(category: String)
}

extension JokesRequest: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.chucknorris.io/jokes")!
    }
    
    var path: String {
        switch self {
        case .random, .randomInCategory:
            return "/random"
        case .categories:
            return "/categories"
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
        case .randomInCategory(let category):
            return .requestParameters(parameters: ["category" : category], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}
