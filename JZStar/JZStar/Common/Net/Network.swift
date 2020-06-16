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
        NetworkLoggerPlugin(configuration: .init(formatter: .init(requestData: { data in
            let body = String.init(data: data, encoding: .utf8) ?? ""
            return "formatted request body = \(body)"
        }),
        logOptions: .verbose)),
//        NetworkActivityPlugin(networkActivityClosure: { (changeType, targetType) in
//            switch changeType{
//            case .began:
//                //                StellarProgressHUD.showHUD()
//                break
//            case.ended:
//                //                StellarProgressHUD.dissmissHUD()
//                break
//            }
//        }),
        AuthPlugin(),
//        CachePolicyPlugin()
    ]
    
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
        sharedManager.request(provider: provider, target: target, success: { json in
            success(json)
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
