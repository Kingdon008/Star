//
//  AppAssistance.swift
//  JZStar
//
//  Created by don on 2019/12/5.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class AppAssistance: NSObject {
    
    /// 获取软件版本
    static func appVersion() -> String{
           (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
       }
    
    /// 获取软件BuildVersion
    static func appBuildVersion() -> String{
        (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? ""
    }
    
    /// 获取上次保存时的软件版本
    static func lastAppVersion() -> String{
        guard let version = userDefaults.value(forKey:"CFBundleShortVersionString") as? String else {
            return ""
        }
        return version
    }
    
    /// 获取软件名称
    static func appName() -> String{
        (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
    }
    
    /// 保存信息
    static func saveVersion(){
        userDefaults.setValue(AppAssistance.appVersion(), forKey: "CFBundleShortVersionString")
        userDefaults.synchronize()
    }
    
}
