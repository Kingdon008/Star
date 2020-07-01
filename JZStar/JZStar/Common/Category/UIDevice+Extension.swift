//
//  UIDevice+Extension.swift
//  JZStar
//
//  Created by don on 2020/7/1.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

let appAccountKey = "appAccountKey"
public extension UIDevice {
/**
        从钥匙串读取idfv
     */
    var keychainIdfv: String {
        
        let idfv = identifierForVendor?.uuidString
        if let bundleId = Bundle.main.bundleIdentifier{
            let lastKeyChianIdfv = SAMKeychain.password(forService: bundleId, account: appAccountKey)
            if lastKeyChianIdfv?.count ?? 0 > 0 {
                return lastKeyChianIdfv ?? ""
            }else {
                // 存到钥匙串里
                SAMKeychain.setPassword(idfv ?? "", forService: bundleId, account: appAccountKey)
            }
        }
        return idfv ?? ""
    }
}
