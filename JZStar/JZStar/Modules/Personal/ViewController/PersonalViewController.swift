//
//  RecommendViewController.swift
//  JZStar
//
//  Created by don on 2020/6/1.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController {
    var tableview:UITableView?
    var viewModel = PersonVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    func setupView(){
        tableview = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - BOTTOM_TABBAR_HEIGHT - getAllVersionSafeAreaBottomHeight()))
        tableview?.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        tableview?.separatorColor = UIColor.init(hexString: "#C3CBD3")
        if let tb = tableview {
            view.addSubview(tb)
        }
    }
    
    func setupData(){
        if let tb = tableview {
            viewModel.tableViewDataModel.targetTableView(myTableview: tb)
            viewModel.vmDelegate = self
            viewModel.setData {
                tb.reloadData()
            }
        }
    }
}

extension PersonalViewController:PersonVMDelegate {
    func pushViewController(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
