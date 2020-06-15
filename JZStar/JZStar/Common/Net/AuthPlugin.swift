//
//  AuthPlugin.swift
//  JZStar
//
//  Created by don on 2020/3/30.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

final class AuthPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        guard let myTarget = target as? NetRequestAPI  else {
            return request
        }
        switch myTarget {
        default:
//            if !AppManager.sharedManager.user.token.accessToken.isEmpty {
//                request.addValue("Bearer \(AppManager.sharedManager.user.token.accessToken)", forHTTPHeaderField: "Authorization")
//            }
            break
        }
        return request
    }
}
