//
//  MyResumeVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumeVC: BaseViewController {
    var tableView:UITableView?
    var viewModel = MyResumeVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupData()
    }
    
    func setupview(){
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        navView.setTitle(title: "我的简历")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        tableView = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY + 15, width: kScreenWidth, height: kScreenHeight -  navView.frame.maxY - 15 - getAllVersionSafeAreaBottomHeight()))
        if let tb = tableView {
            view.addSubview(tb)
        }
    }
    
    func setupData(){
        if let tb = tableView {
            viewModel.tableViewDataModel.targetTableView(myTableview: tb)
        }
        viewModel.setData {
            self.tableView?.reloadData()
        }
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: kStatusBarH, width: kScreenWidth, height: kNavigationBarH)
        let view = NavView(frame: frame)
        return view
    }()
}
