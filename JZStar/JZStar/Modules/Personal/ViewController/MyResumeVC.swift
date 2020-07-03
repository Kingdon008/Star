//
//  MyResumeVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumeVC: BaseViewController {
    var myResumeModel:MyResumeModel?
    var tableView:UITableView?
    var viewModel = MyResumeVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupData()
    }
    
    func setupview(){
        view.backgroundColor = UIColor.white
        navView.setTitle(title: "我的简历")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
            
        }
        view.addSubview(navView)
        tableView = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY, width: kScreenWidth, height: kScreenHeight -  navView.frame.maxY - getAllVersionSafeAreaBottomHeight() - 106))
        if let tb = tableView {
            view.addSubview(tb)
        }
        view.addSubview(authenticationBtn)
        authenticationBtn.frame = CGRect.init(x: kScreenWidth - authenticationBtn.mj_w, y: navView.frame.maxY + 15, width: 106, height: 64)
    }
    
    func setupData(){
        if let tb = tableView {
            viewModel.tableViewDataModel.targetTableView(myTableview: tb)
            viewModel.vmDelegate = self
        }
        Network.request(.usercenterMy_resume(uid: (AppManager.sharedManager.user.uid ?? "")), success: { json in
            if let status = json["status"].int,status == 1 {
                self.myResumeModel = json["data"].description.kj.model(MyResumeModel.self)
                self.viewModel.myResumeModel = self.myResumeModel
                if self.myResumeModel?.resume.is_attestation ?? false{
                    self.authenticationBtn.setImage(UIImage.init(named: "authenticationResume"), for: .normal)
                }else{
                    self.authenticationBtn.setImage(UIImage.init(named: "unAuthenticationResume"), for: .normal)
                }
                self.viewModel.setData {
                    self.tableView?.reloadData()
                }
            }
            
        }) { (err, mess) in
            
        }
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: kStatusBarH, width: kScreenWidth, height: kNavigationBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
    lazy var authenticationBtn:UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "unAuthenticationResume"), for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    
    @IBAction func submitAction(_ sender: Any) {
        guard let model = myResumeModel?.resume else {
            TOAST(message: "提交失败")
            return
        }
//        if model.is_attestation ?? false {
//            return
//        }
        model.uid = AppManager.sharedManager.user.uid ?? ""
        model.name = viewModel.myResumeName
        model.age = viewModel.myResumeAge
        model.personal_description = viewModel.myResumeIntroduction
        MBProgressHUD.showStellarHud()
        Network.request(.usercenterEdit_myresume(model: model), success: { (json) in
            MBProgressHUD.hiddenStellarHud()
            if let status = json["status"].int,status == 1 {
                TOAST(message: "提交成功")
                if let resume_percent = json["data"]["resume_percent"].int{
                    NotificationCenter.default.post(name: .MyResumeCompletePer, object: nil, userInfo: ["MyResumeCompletePer" : "\(resume_percent)"])
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else{
                TOAST(message: "提交失败")
            }
        }) { (err, mess) in
            MBProgressHUD.hiddenStellarHud()
            TOAST(message: "提交失败")
        }
    }
}

extension MyResumeVC:MyResumeVMDelegate{
    func modificationInfo(param: [String : Any]) {
        let model = param.kj.model(ResumeModel.self)
        self.myResumeModel?.resume = model
    }
    
    
}
