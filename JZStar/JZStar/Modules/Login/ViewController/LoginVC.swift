//
//  LoginVC.swift
//  JZStar
//
//  Created by don on 2020/6/8.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    
    override func viewDidLoad() {
        setupViews()
        sendLoginCode()
    }
    
    func setupViews(){
        view.backgroundColor = UIColor.white
        view.addSubview(codeLoginView)
        codeLoginView.snp.makeConstraints { (make) in
            make.top.equalTo(300)
            make.height.equalTo(400)
            make.left.right.equalTo(0)
        }
    }
    
    private func setupAction(){
        codeLoginView.phoneClickBlock = { [weak self] (country,num) in
            self?.codeLoginView.bottomBtn.startIndicator()
        }
    }
    
    
    ///发送登录的验证码登录
    private func sendLoginCode(){
        codeLoginView.phoneClickBlock = { country,phone in
            self.codeLoginView.bottomBtn.startIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:{
                self.codeLoginView.bottomBtn.stopIndicator()
                AppManager.sharedManager.nextStep()
            })
        }
        
        
    }
    
   
    //MARK:lazy
    private lazy var codeLoginView:AccountOrPasswordView = {
        let cView = AccountOrPasswordView()
        cView.myTextfieldViewState = .kPhoneTextfieldType
        return cView
    }()
    
}
