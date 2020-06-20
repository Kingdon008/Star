//
//  LoginVC.swift
//  JZStar
//
//  Created by don on 2020/6/8.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    var codeView:UIControl?
    var codeString:String?
    
    @IBOutlet weak var identifyingCodeBg: UIView!
    override func viewDidLoad() {
        setupViews()
        refreshCode()
    }
    
    func setupViews(){
        
    }
    @IBAction func loginAction(_ sender: Any) {
        AppManager.sharedManager.nextStep()
    }
   
    private func refreshCode() {
        if codeView != nil {
            codeView?.removeFromSuperview()
        }
        let result = ImageCodeVerification.create(CGRect(x: 0, y: 0, width: 111, height: 46))
        codeView = result.obj
        codeView?.addTarget(self, action: #selector(refreshClickAction), for: .touchUpInside)
        codeString = result.code
        guard codeView != nil && codeString?.count ?? 0 > 0 else {
            return
        }
        identifyingCodeBg.addSubview(codeView!)
    }
    
    @objc func refreshClickAction(){
        refreshCode()
    }

}
