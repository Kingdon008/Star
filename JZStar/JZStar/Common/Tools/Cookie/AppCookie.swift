//
//  AppCookie.swift
//  JZStar
//
//  Created by don on 2019/12/5.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class AppCookie: NSObject {
    var isDirty = false
    ///当前用户启动的次数
    var launchedCount:NSInteger{
        didSet{
            userDefaults.setValue(launchedCount, forKey: AppAssistance.appVersion()+userIdentifier)
            isDirty = true
        }
    }
    ///当前用户的唯一表示符
    var userIdentifier:String{
        didSet{
            userDefaults.setValue(userIdentifier, forKey: keyAppCookie + "currentUser")
            isDirty = true
        }
    }
    
    override init() {
        userIdentifier = (userDefaults.object(forKey: keyAppCookie + "currentUser") as? String) ?? ""
        launchedCount =  (userDefaults.object(forKey:AppAssistance.appVersion()+userIdentifier) as? NSInteger) ?? 0
    }
    
    ///当有修改时保存
    func save(){
        if isDirty {
            userDefaults.synchronize()
        }
    }
    
    func clear(){
        launchedCount = 0
        userIdentifier = ""
        userDefaults.synchronize()
    }
}
