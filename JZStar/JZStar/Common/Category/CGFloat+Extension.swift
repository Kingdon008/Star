//
//  CGFloat+Extension.swift
//  StellarHomeIOS
//
//  Created by don on 2020/3/12.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

extension CGFloat: SSCompatible {}
extension SS where Base == CGFloat {
    ///截断 到小数点后某一位
    func truncate(places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return CGFloat(Int(base * divisor)) / divisor
    }
}
