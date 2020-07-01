//
//  NetRequestAPI.swift
//  JZStar
//
//  Created by don on 2020/3/20.
//  Copyright © 2020 don. All rights reserved.
//

import AdSupport

public enum NetRequestAPI {
    case homeContent
    case homePosition(id:Int,limit:Int)
    case homeBanner
    case positionContent(id:Int)
    case boutiqueList(limit:Int)
    case userCenterHome(uid:String)
    case userCenterPosition(uid:String)
    case usercenterAboutus
    case usercenterSave_position(uid:String,status_id:Int,position_id:Int)
    case usercenterMy_resume(uid:String)
    case usercenterEdit_myresume(model:ResumeModel)
    case usercenterCustom_service
    case usercenterIdea(type:Int,content:String,uid:String)
    case usercenterVerify_code(phone:String)
    case usercenterRegister(phone:String,verify_code:String)
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
        case .usercenterAboutus:
            return .get
        case .usercenterSave_position:
            return .post
        case .usercenterMy_resume:
            return .post
        case .usercenterEdit_myresume:
            return .post
        case .usercenterCustom_service:
            return .get
        case .usercenterIdea:
            return .post
        case .usercenterVerify_code:
            return .post
        case .usercenterRegister:
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
            return "usercenter/home"
        case .userCenterPosition:
            return "usercenter/my_position"
        case .usercenterAboutus:
            return "usercenter/about"
        case .usercenterSave_position:
            return "usercenter/save_position"
        case .usercenterMy_resume:
            return "usercenter/my_resume"
        case .usercenterEdit_myresume:
            return "usercenter/edit_myresume"
        case .usercenterCustom_service:
            return "usercenter/custom_service"
        case .usercenterIdea:
            return "usercenter/idea_complaint"
        case .usercenterVerify_code:
            return "/usercenter/verify_code"
        case .usercenterRegister:
            return "/usercenter/register"
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
        case .usercenterSave_position(let uid,let status_id,let position_id):
            param = ["uid":uid,"status_id":status_id,"position_id":position_id]
        case .usercenterMy_resume(let uid):
            param = ["uid":uid]
        case .usercenterEdit_myresume(let model):
            param = model.kj.JSONObject()
        case .usercenterIdea(let type, let content,let uid):
            param = ["type":type,"content":content,"uid":uid]
        case .usercenterVerify_code(let phone):
            param = ["phone":phone]
        case .usercenterRegister(let phone,let verify_code):
            param = ["phone":phone,"verify_code":verify_code]
            let sysVersion = UIDevice.current.systemVersion //获取系统版本 例如：9.2
            param["sysVersion"] = sysVersion
            let deviceUUID = UIDevice.current.keychainIdfv

//            let deviceUUID = UIDevice.current.identifierForVendor?.uuidString
            param["deviceUUID"] = deviceUUID
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                param["idfa"] = idfa
            }
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
