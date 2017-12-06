//
//  Poster.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 18/10/2017.
//
import Moya

enum ImageTMDB {
    case posterId(String)
}

extension ImageTMDB: TargetType {
    
    var baseURL: URL { return URL(string: BundleReader().valueForPosterBaseURL())! }
    
    var path: String {
        switch self {
        case .posterId (let id):
            // as a future improvement this size could be set dynamically depending on the device resolution
            return "w300_and_h450_bestv2\(id)"
        default:
            return ""
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        return nil
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    var task: Task {
        return .requestPlain
    }
    var sampleData: Data {
        switch self {
        case .posterId(_):
            return "".data(using: .utf8)!
        }
    }
    var validate: Bool {
        return false
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

