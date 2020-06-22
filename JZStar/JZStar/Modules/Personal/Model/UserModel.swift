//
//  UserModel.swift
//  JZStar
//
//  Created by herodon on 2020/6/19.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class UserModel: Convertible {
    var uid:String?
    var name:String?
    var sex:Int?
    var age:String?
    var education:String?
    var major:String?
    var interest_profession:String?
    var personal_description:String?
    var profit:String?
    var resume_percent:String?
    var headimgurl:String?
    var phone:Int?
    
    required public init() {
        // Intentionally unimplemented...
    }
}
