//
//  AppDelegate.swift
//  JZStar
//
//  Created by don on 2020/6/1.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configUMeng()
        IQKeyboardManager.shared.enable = true
        AppManager.sharedManager.startWithAppDelegate(appDelegate: self)
        return true
    }

    func configUMeng() {
        UMConfigure.setLogEnabled(true)
        UMConfigure.initWithAppkey("5ef80104978eea088379e269", channel: nil)
        
        /* 设置微信的appKey和appSecret */
        let manager = UMSocialManager.default()
        manager?.setPlaform(.wechatSession, appKey: "wx0dd54e1d12cc6e82", appSecret: "842abd9f3ab8cb040180cd9686cbe59b", redirectURL: "http://mobile.umeng.com/social")
    }

}

