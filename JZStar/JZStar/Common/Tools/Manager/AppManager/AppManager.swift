//
//  AppManager.swift
//  SwiftTest
//
//  Created by don on 2019/7/2.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

enum AppMangerStep:Int{
    case kAppStepInit = 0
    case kAppStepLaunch = 1
    case kAppStepLogin = 2
    case kAppStepMain = 3
    case kAppStepLogout = 4
}

class AppManager: NSObject {
    private var mainVc:MainViewController?
    static let sharedManager = AppManager.init()
    var currentStep:AppMangerStep?{
        didSet{
            if oldValue != currentStep{
                configure()
            }
        }
    }
    
    var currVc:UIViewController?
    
    func startWithAppDelegate(appDelegate:AppDelegate){
        appDelegate.window = window
        currentStep = .kAppStepInit
        cookie.launchedCount += 1
    }
    
    @objc func nextStep(){
        doSomethingBeforeSwitch()
        currentStep = AppMangerStep(rawValue: currentStep!.rawValue + 1)!
    }
    
    func enterBackgroundState(){
        
    }
    func enterForegroundState(){
        
    }
    
    private func configure(){
        switch currentStep {
        case .kAppStepInit?:
            configureInit()
            break
        case .kAppStepLaunch?:
            configureLaunch()
            break
        case .kAppStepLogin?:
            configureLogin()
            break
        case .kAppStepMain?:
            configureMain()
            break
        case .kAppStepLogout?:
            currentStep = .kAppStepInit
            break
        default:
            break
        }
    }
    
    private func configureInit(){
        ///此处可以加载一些必要的数据
        user.loadUserWithIdentifer(identifier: cookie.userIdentifier)
        nextStep()
    }
    
    private func configureLaunch(){
        nextStep()
    }
    
    private func configureLogin(){
        print(user.uid)
        if user.uid != nil {
            nextStep()
        }else{
            let vc = LoginVC()
            let nav = MyRootNavViewController(rootViewController: vc)
            switchToVC(vc: nav)
        }
    }
    
    func setMainViewState(state:ViewState){
        mainVc?.myViewState = state
    }
    
    private func configureMain(){
        self.mainVc = MainViewController()
        if let main = self.mainVc{
            let nav = MyRootNavViewController(rootViewController: main)
            switchToVC(vc: nav)
        }else{
            nextStep()
        }
    }
    
    private func switchToVC(vc:UIViewController){
        if window.rootViewController == nil {
            self.window.rootViewController = vc
            self.window.makeKeyAndVisible()
            self.currVc = vc
            return
        }
        let animationOptions = UIView.AnimationOptions.transitionFlipFromLeft
        UIView.transition(with: window, duration: 1, options: animationOptions, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.window.rootViewController = vc
            self.window.makeKeyAndVisible()
            self.currVc = vc
            UIView.setAnimationsEnabled(oldState)
        }, completion: nil)
    }
    
    
    private func doSomethingBeforeSwitch(){
        //会添加一下配置的信息在部分节点上
        if currentStep == .kAppStepLogin {
            if let cookieUID = user.uid {
                cookie.userIdentifier = cookieUID
            }
            user.hasLogined = true
            user.save()
            cookie.save()
        }else if currentStep == .kAppStepMain {
            cookie.clear()
            user.clear()
            user = AppUser()
        }
    }
    
    //MARK:lazy
    private lazy var window:UIWindow = {
        let view = UIWindow.init(frame: UIScreen.main.bounds)
        return view
    }()
    
    lazy var cookie:AppCookie = {
        let cookie = AppCookie()
        return cookie
    }()
    
    lazy var user:AppUser = {
        let user = AppUser()
        return user
    }()
    
}
