//
//  ToolsFunction.swift
//  Stellar Wi-Fi
//
//  Created by don on 2018/11/23.
//  Copyright © 2018 zhouqitian. All rights reserved.
//

import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import MBProgressHUD
// MARK:适配相关
/// 获取屏幕比例系数
func fitLength() -> CGFloat{
    return (kScreenWidth < kScreenHeight ? kScreenWidth : kScreenHeight) / 375.0
}

func getAllVersionSafeAreaTopHeight() -> CGFloat {
    return kNavigationH - NAVVIEW_HEIGHT_DISLODGE_SAFEAREA
}

func getAllVersionSafeAreaBottomHeight() -> CGFloat {
    if #available(iOS 11.0, *){
        return safeAreaBottomHeight!
    }
    return 0
}

// MARK:获取系统相关
/// 快速国际化
///
/// - Parameter str: 国际化ID
/// - Returns: result
func StellarLocalizedString(_ str: String) -> String {
    return NSLocalizedString(str, comment: str)
}

/// 获取WiFi信息
///
/// - Returns: SSID及MAC的元组
func getWifiInfo() -> (ssid: String?, mac: String?) {
    if let cfas: NSArray = CNCopySupportedInterfaces() {
        for cfa in cfas {
            if let dict = CFBridgingRetain(
                CNCopyCurrentNetworkInfo(cfa as! CFString)
                ) {
                if let ssid = dict["SSID"] as? String,
                    let bssid = dict["BSSID"] as? String {
                    return (ssid, bssid)
                }
            }
        }
    }
    return (nil, nil)
}

/// 获取keywindow
public func getKeyboardWindow() -> UIWindow {
    return UIApplication.shared.keyWindow!
}

/// 获取当前的根视图控制器
func CURRENT_ROOT_VC() -> UIViewController {
    return getKeyboardWindow().rootViewController!
}

/// 获取当前屏幕展示的控制器
func CURRENT_TOP_VC() -> UIViewController {
    return getTopVc(rootVc: CURRENT_ROOT_VC())
}

// 递归查找控制器
private func getTopVc(rootVc: UIViewController) -> UIViewController {
    if rootVc.presentedViewController != nil {
        return getTopVc(rootVc: rootVc.presentedViewController!)
    }else if rootVc.isKind(of: UITabBarController.self) {
        return getTopVc(rootVc: (rootVc as! UITabBarController).selectedViewController!)
    }else if rootVc.isKind(of: UINavigationController.self) {
        return getTopVc(rootVc: (rootVc as! UINavigationController).visibleViewController!)
    }
    return rootVc
}

// MARK:便捷方法
///生成随机数
func randomCustom(min: CGFloat, max: CGFloat) -> CGFloat {
    let y = arc4random() % UInt32(max) + UInt32(min)
    return CGFloat(y)
}

/// 中间文字 弹窗
func TOAST(message: String,completeBlock:(() ->Void)? = nil) {
    StellarHintHud.toast(message: message, contentType: .center, completeBlock: completeBlock)
}

/// 底部文字 弹窗
func TOAST_BOTTOM(message: String) {
    StellarHintHud.toast(message: message, contentType: .bottom, completeBlock: nil)
}

/// 成功提示 弹窗
func TOAST_SUCCESS(message: String, completeBlock:(() ->Void)? = nil) {
    MBProgressHUD.showStellarHudSuccessfulWith(message, successBlock: completeBlock)
}

/// 使用系统浏览器跳转到指定网页
///
/// - Parameter url: 网址
func jumpTo(url: String){
    guard url != "" else {
        return
    }
    if let url:URL = URL.init(string: url) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            if url.absoluteString.hasPrefix("sinaweibo") {
                TOAST(message: "未安装新浪微博App")
            }
        }
    }
}


func getFrontWindow() -> UIWindow? {
    let frontToBackWindows = UIApplication.shared.windows.reversed()
    for window in frontToBackWindows {
        let windowOnMainScreen = window.screen == UIScreen.main
        let windowIsVisible = !window.isHidden && window.alpha > 0
        let windowLevelSupported = (window.windowLevel >= .normal && window.windowLevel <= .normal)
        let windowKeyWindow = window.isKeyWindow
        if windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow {
            return window
        }
    }
    return nil
}
