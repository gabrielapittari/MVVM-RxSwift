//
//  DataProvider.swift
//  PremierSwift
//
//  Created by Gabriela Pittari on 18/10/2017.
//
import Moya

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

enum TheMovieDB {
    case paged(String)
}


extension TheMovieDB: TargetType {
    var baseURL: URL {
        switch self {
        case .paged (let page):
            return URL(string: "\(BundleReader().valueForBaseURL())?page=\(page)&api_key=\(BundleReader().valueForAPIKey())")!
        }
    }
    var path:String {
        switch self {
        case .paged (_):
            return "movie/top_rated"
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        switch self {
        case .paged (_):
            return ["": ""]
        }
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    var sampleData: Data {
        switch self {
        case .paged(_):
            return BundleReader().valueForMovieSample().data(using: .utf8)!
        }
    }
    var task: Task {
        return .requestPlain
    }
    var validate: Bool {
        return false
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
