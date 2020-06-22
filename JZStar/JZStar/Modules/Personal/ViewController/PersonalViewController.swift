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
    var userModel:UserModel?
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
        Network.request(.userCenterHome(uid: "ababababab"), success: { (json) in
            self.userModel = json["data"].description.kj.model(UserModel.self)
            self.viewModel.userModel = self.userModel
            self.viewModel.setData {
                self.tableview.reloadData()
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
