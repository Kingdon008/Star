//
//  InfoModel.swift
//  StellarHomeIOS
//
//  Created by don on 2019/7/9.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class InfoModel: Convertible {

    @objc var userid:String = ""
    @objc var cellphone:String = ""
    @objc var subscribe:Bool = false
    @objc var nickname:String = ""
    @objc var avatar:String = ""
    @objc var email:String = ""
    
    required init() {
        
    }
    
    func kj_modelValue(from jsonValue: Any?, _ property: Property) -> Any? {
        switch property.name {
        case "nickname":
            if (jsonValue as? String) == nil {
                return ""
            }
            return jsonValue
        default:
            return jsonValue
        }
    }
}
