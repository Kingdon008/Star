//
//  InfoModel.swift
//  StellarHomeIOS
//
//  Created by don on 2019/7/9.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class TokenModel: Convertible {
    
    @objc var accessToken:String = ""
    @objc var refreshToken:String = ""
    @objc var id:String = ""
    
    required init() {
        
    }
}
