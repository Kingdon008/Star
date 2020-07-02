//
//  RecommendViewController.swift
//  JZStar
//
//  Created by don on 2020/6/1.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController {
    var tableview:UITableView!
    var viewModel = PersonVM()
    var userModel:AppUser?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    func setupView(){
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - BOTTOM_TABBAR_HEIGHT - getAllVersionSafeAreaBottomHeight()))
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        tableview.separatorColor = UIColor.init(hexString: "#C3CBD3")
        view.addSubview(tableview)
    }
    
    func setupData(){
        viewModel.tableViewDataModel.targetTableView(myTableview: tableview)
        viewModel.vmDelegate = self
        NotificationCenter.default.rx.notification (.MyResumeCompletePer)
        .subscribe(onNext: { [weak self] (nitify) in
            let info = nitify.userInfo
            if let per = info?["MyResumeCompletePer"] as? String{
                self?.userModel?.resume_percent = per
                self?.viewModel.userModel?.resume_percent = per
                self?.viewModel.tableViewDataModel.tableView?.reloadData()
            }
        }).disposed(by: disposeBag)
        
        Network.request(.userCenterHome(uid: (AppManager.sharedManager.user.uid ?? "")), success: { (json) in
            if let status = json["status"].int,status == 1 {
                self.userModel = json["data"].description.kj.model(AppUser.self)
                let jsonStr = json["data"].description
                AppManager.sharedManager.user.kj_m.convert(from: jsonStr)
                AppManager.sharedManager.user.save()
                self.viewModel.userModel = self.userModel
                self.viewModel.setData {
                    self.tableview.reloadData()
                }
            }
        }) { (err, mess) in
            
        }
    }
}

extension PersonalViewController:PersonVMDelegate {
    func pushViewController(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
