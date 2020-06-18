//
//  NetRequestAPI.swift
//  JZStar
//
//  Created by don on 2020/3/20.
//  Copyright © 2020 don. All rights reserved.
//

public enum NetRequestAPI {
    case homeContent
    case homePosition(id:Int,limit:Int)
    case homeBanner
    case positionContent(id:Int)
    case boutiqueList(limit:Int)
    case userCenterHome(uid:String)
    case userCenterPosition(uid:String)
}

extension NetRequestAPI: TargetType {
    public var baseURL: URL {
        return URL(string:"http://106.14.140.138/jianzhi/index.php")!
    }
    
    public var method: Moya.Method {
        switch self {
        case .homeContent:
            return .get
        case .homePosition:
            return .post
        case .homeBanner:
            return .get
        case .positionContent:
            return .post
        case .boutiqueList:
            return .post
        case .userCenterHome:
            return .post
        case .userCenterPosition:
            return .post
        }
    }
    
    public var path: String {
        switch self {
        case .homeContent:
            return "/home/home_content"
        case .homePosition:
            return "/home/home_position"
        case .homeBanner:
            return "home/home_banner"
        case .positionContent:
            return "cms/position_content"
        case .boutiqueList:
            return "cms/boutique_list"
        case .userCenterHome:
            return "userCenterHome/ home"
        case .userCenterPosition:
            return "usercenter/my_position"
        }
    }
    
    
    public var task: Task {
        var param: [String: Any] = [:]
        switch self {
        case .homePosition(let id, let limit):
            param = ["id":id,"limit":limit]
        case .positionContent(let id):
            param = ["id":id]
        case .boutiqueList(let limit):
            param = ["limit":limit]
        case .userCenterHome(let uid):
            param = ["uid":uid]
        case .userCenterPosition(let uid):
            param = ["uid":uid]
        default :
            break
        }
        if param.count > 0 {
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
        return .requestPlain
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8, allowLossyConversion: true)!
    }
    
    //请求头设置
    public var headers: [String : String]? {
        var header = [String : String]()
        header["Content-type"] = "application/json; charset=utf-8"
        return header
    }
}

extension Moya.Response{
    func json<T>() -> T?{
        guard
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? T else {
                return nil
        }
        return json
    }
}

struct JSONArrayEncoding: ParameterEncoding {
    static let `default` = JSONArrayEncoding()
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        guard let json = parameters?["jsonArray"] else {
            return request
        }
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        request.httpBody = data
        return request
    }
}
