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
        return request
    }
}
