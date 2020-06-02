//
//  CachePolicyPlugin.swift
//  JZStar
//
//  Created by don on 2020/5/12.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

final class CachePolicyPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutableRequest = request
        mutableRequest.cachePolicy = .returnCacheDataElseLoad
        return mutableRequest
    }
}

