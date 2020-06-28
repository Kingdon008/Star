//
//  LoginVC.swift
//  JZStar
//
//  Created by don on 2020/6/8.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    private var timer: SSTimeTask!
    var codeView:UIControl?
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var phonecodeTextfield: UITextField!
    @IBOutlet weak var graphCodeTextfield: UITextField!
    var codeString:String?
    @IBOutlet weak var identifyingCodeBg: UIView!
    @IBOutlet weak var getPhoneCodeBtn: UIButton!
    
    override func viewDidLoad() {
        setupViews()
        refreshCode()
    }
    
    func setupViews(){
        
    }
   
    @objc func refreshClickAction(){
        refreshCode()
    }

    @IBAction func getCodeAction(_ sender: Any) {
        guard let phone = phoneTextfield.text else {
            TOAST(message: "手机号码为空")
            return
        }
        if graphCodeTextfield.text !=  codeString{
            TOAST(message: "验证码错误")
            return
        }
        timer = SSTimeManager.shared.addTaskWith(timeInterval: 1, isRepeat: true) { [weak self] (task) in
            if task.repeatCount < 60 {
                self?.getPhoneCodeBtn.setTitle("\(task.repeatCount)秒后重试", for: .normal)
                self?.getPhoneCodeBtn.isEnabled = false
            }else{
                task.isStop = true
                self?.getPhoneCodeBtn.setTitle("获取验证码", for: .normal)
                self?.getPhoneCodeBtn.isEnabled = true
            }
        }
        Network.request(.usercenterVerify_code(phone: phone), success: { (json) in
            self.phonecodeTextfield.becomeFirstResponder()
        }) { (err, message) in
            TOAST(message: "发送验证码失败")
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let phone = phoneTextfield.text else {
            return
        }
        if phone.isEmpty {
            TOAST(message: "手机号码为空")
            return
        }
        guard let phoneCode = phonecodeTextfield.text else {
            return
        }
        if phoneCode.isEmpty {
            TOAST(message: "手机验证码为空")
            return
        }
        if graphCodeTextfield.text !=  codeString{
            TOAST(message: "图形验证码错误")
            return
        }
        Network.request(.usercenterRegister(phone: phone, verify_code: phoneCode), success: { (json) in
            if let status = json["status"].int,status == 1 {
                if let uid = json["data"]["uid"].string {
                    TOAST(message: "登录成功")
                    AppManager.sharedManager.user.uid = uid
                    AppManager.sharedManager.user.phone = json["data"]["phone"].string
                    AppManager.sharedManager.nextStep()
                }
            }else{
                TOAST(message: "登录失败")
            }

        }) { (error, mess) in
            TOAST(message: "登录失败")
        }
        
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
}
