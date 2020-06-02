//
//  Network.swift
//  JZStar
//
//  Created by don on 2020/3/21.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: Any]

class Network: NSObject{
    static let sharedManager = Network.init()
    typealias Success = ((JSON) -> Void)
    typealias Failure = ((MoyaError, String) -> Void)
    typealias Progress = ((Double, Bool) -> Void)
    var isRefreshingToken = false
    var targets = [(NetRequestAPI,Success,Failure)]()
    var plugins:[PluginType] = [
//        NetworkLoggerPlugin(verbose: false),
        NetworkActivityPlugin(networkActivityClosure: { (changeType, targetType) in
            switch changeType{
            case .began:
                //                StellarProgressHUD.showHUD()
                break
            case.ended:
                //                StellarProgressHUD.dissmissHUD()
                break
            }
        }),
        AuthPlugin(),
        CachePolicyPlugin()
    ]
    
    //    let failureEndpointClosure = { (target: NetRequestAPI) -> Endpoint in
    //        let sampleResponseClosure = { () -> (EndpointSampleResponse) in
    //            return .networkResponse(200, target.sampleData)
    //        }
    //        let url = URL(target: target).absoluteString
    //        return Endpoint(url: url, sampleResponseClosure: sampleResponseClosure, method: target.method, task: target.task, httpHeaderFields: target.headers)
    //    }
    
    let stubClosure: (_ type: NetRequestAPI) -> Moya.StubBehavior  = { type1 in
        return StubBehavior.never
    }
    
    static func request(_ target: NetRequestAPI,
                        viewController: UIViewController? = nil,
                        success: @escaping Success,
                        failure: @escaping Failure){
        var plugins = Network.sharedManager.plugins
        let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 5
                done(.success(request))
            } catch {
                done(.failure(MoyaError.underlying(error, nil)))
            }
        }
        let provider = MoyaProvider<NetRequestAPI>(requestClosure: requestClosure,stubClosure: Network.sharedManager.stubClosure, plugins:plugins)
//        switch target {
//        case .queryAllRooms:
//            break
//        case .queryDevicesVersionDescription(_,_,_):
//            break
//        case .devicesUpgradeInfo(_,_):
//            break
//        case .queryDevicesAddList:
//            break
//        default:
//            provider.manager.delegate.sessionDidReceiveChallenge = { session, challenge in
//                return Self.formateHTTPSAuthentication(challenge: challenge)
//            }
//            break
//        }
        sharedManager.request(provider: provider, target: target, success: { json in
            let code = json["code"].intValue
            if code == 10006 {
                
            }else {
                success(json)
            }
        }, failure: { (error,_) in
            failure(error, "")
        })
    }
    
    private func request(provider:MoyaProvider<NetRequestAPI>,target:NetRequestAPI,success: @escaping Success,failure: @escaping Failure){
        provider.request(target) {
            switch $0{
            case .success(let response):
                let json: JSON = JSON(response.data)
                success(json)
            case .failure(let error):
                failure(error, "")
            }
        }
    }
}

//定义一个结构体，存储认证相关信息
struct IdentityAndTrust {
    var identityRef:SecIdentity
    var trust:SecTrust
    var certArray:AnyObject
}
