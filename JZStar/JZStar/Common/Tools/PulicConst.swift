
//
//  Common.swift
//  JZStar
//
//  Created by don on 2018/8/29.
//  Copyright © 2018年 zhouqitian. All rights reserved.
//

import Foundation
import UIKit
import SwiftRichString

enum ValidateResult {
    case ok
    case failed(ValidateFailReason)
    var isOk: Bool {
        if case ValidateResult.ok = self {
            return true
        }else{
            return false
        }
    }
}

enum ValidateFailReason{
    case emptyInput
    case other(String)
}

let userDefaults = UserDefaults.standard
let kStatusBarH = UIApplication.shared.statusBarFrame.size.height //状态栏高度x:44
let kNavigationBarH = UINavigationController.init().navigationBar.frame.height  //导航栏Bar高度
let kNavigationH = (kStatusBarH + kNavigationBarH)
let kScreenWidth = UIScreen.main.bounds.size.width                              //屏幕宽
let kScreenHeight = UIScreen.main.bounds.size.height                             //屏幕高
let BOTTOM_TABBAR_HEIGHT:CGFloat = 49.0                                                       //tabbar的高度
/// 适配比例
let ratio = (kScreenWidth < kScreenHeight ? kScreenWidth : kScreenHeight) / 375.0
/// 判断是否刘海屏
var isIphoneX_serious: Bool {
    if UIDevice.current.userInterfaceIdiom == .pad {
        return false
    }
    let size = UIScreen.main.bounds.size
    let notchValue: Int = Int(size.width/size.height * 100)
    if 216 == notchValue || 46 == notchValue {
        return true
    }
    return false
}

// MARK: - Public Color
let STELLAR_COLOR_C1: UIColor = UIColor.init(hexString: "#0A41A8")
let STELLAR_COLOR_C2: UIColor = UIColor.init(hexString: "#CD3232")
let STELLAR_COLOR_C3: UIColor = UIColor.init(hexString: "#ffffff")
let STELLAR_COLOR_C4: UIColor = UIColor.init(hexString: "#272A35")
let STELLAR_COLOR_C5: UIColor = UIColor.init(hexString: "#272A35")
let STELLAR_COLOR_C6: UIColor = UIColor.init(hexString: "#95949B")
let STELLAR_COLOR_C7: UIColor = UIColor.init(hexString: "#C5C9D1")
let STELLAR_COLOR_C8: UIColor = UIColor.init(hexString: "#F0F2F5")
let STELLAR_COLOR_C9: UIColor = UIColor.init(hexString: "#F3F4F9")
let STELLAR_COLOR_C10: UIColor = UIColor.init(hexString: "#50C48C")
let STELLAR_COLOR_C11: UIColor = UIColor.init(hexString: "#343434")

// MARK: - Public Font regular
let STELLAR_FONT_T32: UIFont = UIFont.systemFont(ofSize: 32, weight: .regular)
let STELLAR_FONT_T30: UIFont = UIFont.systemFont(ofSize: 30, weight: .regular)
let STELLAR_FONT_T20: UIFont = UIFont.systemFont(ofSize: 20, weight: .regular)
let STELLAR_FONT_T18: UIFont = UIFont.systemFont(ofSize: 18, weight: .regular)
let STELLAR_FONT_T17: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
let STELLAR_FONT_T16: UIFont = UIFont.systemFont(ofSize: 16, weight: .regular)
let STELLAR_FONT_T15: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
let STELLAR_FONT_T14: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
let STELLAR_FONT_T13: UIFont = UIFont.systemFont(ofSize: 13, weight: .regular)
let STELLAR_FONT_T12: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
let STELLAR_FONT_T11: UIFont = UIFont.systemFont(ofSize: 11, weight: .regular)

//semibold
let STELLAR_FONT_BOLD_T32: UIFont = UIFont.systemFont(ofSize: 32, weight: .semibold)
let STELLAR_FONT_BOLD_T30: UIFont = UIFont.systemFont(ofSize: 30, weight: .semibold)
let STELLAR_FONT_BOLD_T24: UIFont = UIFont.systemFont(ofSize: 24, weight: .semibold)
let STELLAR_FONT_BOLD_T20: UIFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
let STELLAR_FONT_BOLD_T18: UIFont = UIFont.systemFont(ofSize: 18, weight: .semibold)
let STELLAR_FONT_BOLD_T17: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
let STELLAR_FONT_BOLD_T16: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
let STELLAR_FONT_BOLD_T15: UIFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
let STELLAR_FONT_BOLD_T14: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
let STELLAR_FONT_BOLD_T13: UIFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
let STELLAR_FONT_BOLD_T12: UIFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
let STELLAR_FONT_BOLD_T11: UIFont = UIFont.systemFont(ofSize: 11, weight: .semibold)

//Medium
let STELLAR_FONT_MEDIUM_T32: UIFont = UIFont.systemFont(ofSize: 32, weight: .medium)
let STELLAR_FONT_MEDIUM_T30: UIFont = UIFont.systemFont(ofSize: 30, weight: .medium)
let STELLAR_FONT_MEDIUM_T20: UIFont = UIFont.systemFont(ofSize: 20, weight: .medium)
let STELLAR_FONT_MEDIUM_T18: UIFont = UIFont.systemFont(ofSize: 18, weight: .medium)
let STELLAR_FONT_MEDIUM_T17: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium)
let STELLAR_FONT_MEDIUM_T16: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
let STELLAR_FONT_MEDIUM_T15: UIFont = UIFont.systemFont(ofSize: 15, weight: .medium)
let STELLAR_FONT_MEDIUM_T14: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
let STELLAR_FONT_MEDIUM_T13: UIFont = UIFont.systemFont(ofSize: 13, weight: .medium)
let STELLAR_FONT_MEDIUM_T12: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium)
let STELLAR_FONT_MEDIUM_T11: UIFont = UIFont.systemFont(ofSize: 11, weight: .medium)
let STELLAR_FONT_MEDIUM_T8: UIFont = UIFont.systemFont(ofSize: 8, weight: .medium)

// MARK: - Public safeArea
@available(iOS 11.0, *)
let safeAreaBottomHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom

@available(iOS 11.0, *)
let safeAreaTopHeight = UIApplication.shared.keyWindow?.safeAreaInsets.top

let keyAppUser = "__AppUser_"
let keyAppCookie = "__AppCookie_"

struct Input {
    let textfieldInput: Observable<String>
}
struct Output {
    var textFieldValidateResult: Observable<ValidateResult>!
}

// MARK: - 协议
/// 扩展属性
struct SS<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}
protocol SSCompatible {}
extension SSCompatible {
    static var ss: SS<Self>.Type {
        set {}
        get { SS<Self>.self }
    }
    var ss: SS<Self> {
        set {}
        get { SS(self) }
    }
}

/// SizeFit
protocol SizeFitProtocol {
}
extension Int: SizeFitProtocol {
}
extension CGFloat: SizeFitProtocol {
}
extension Double: SizeFitProtocol {
}
extension UInt: SizeFitProtocol {
}
extension Float: SizeFitProtocol {
}
extension SizeFitProtocol {
    var fit: CGFloat {
        let length: CGFloat
        if let element = self as? Int {
            length = CGFloat(element)
        }else if let element = self as? Double {
            length = CGFloat(element)
        }else if let element = self as? UInt {
            length = CGFloat(element)
        }else if let element = self as? Float {
            length = CGFloat(element)
        }else if let element = self as? CGFloat {
            length = CGFloat(element)
        }else{
            length = 0.0
        }
        return length*ratio
    }
}

// MARK: - Notification
extension Notification.Name {
    // 调整颜色、亮度选择设备完成时通知（场景，智能，面板详情）
    static let MyResumeCompletePer = Notification.Name(rawValue:"MyResumeCompletePer")
}

