//
//  NetRequestAPI.swift
//  JZStar
//
//  Created by don on 2020/3/20.
//  Copyright © 2020 don. All rights reserved.
//

public enum NetRequestAPI {
   
    
}

extension NetRequestAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string:"")!
    }
    
    // 各个请求的具体路径
    public var path: String {
        return ""
    }
    
    
    //请求方式
    public var method: Moya.Method {
        return .get
    }
    
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        var param: [String: Any] = [:]
        return .requestParameters(parameters: param, encoding: JSONEncoding.default)
    }
    
    public var validate: Bool {
        return false
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8, allowLossyConversion: true)!
    }
    
    //请求头设置
    public var headers: [String : String]? {
        var header = [String : String]()
        let uuid = UUID().uuidString
        header["requestId"] = uuid
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
