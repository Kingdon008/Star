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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "个人中心"
        setupView()
        setupData()
    }
    
    func setupView(){
        tableview = UITableView(frame: CGRect(x: 0, y: kNavigationH, width: kScreenWidth, height: kScreenHeight - 88))
        if let tb = tableview {
            view.addSubview(tb)
            tb.delegate = self
            tb.dataSource = self
        }
    }
    
    func setupData(){
        if let tb = tableview {
            viewModel.tableViewDataModel.targetTableView(myTableview: tb)
            viewModel.setData {
                tb.reloadData()
            }
        }
    }
}

extension PersonalViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecommendDetailCell.initWithXIb() as! RecommendDetailCell
        cell.selectionStyle = .none
        return cell
    }
    
    
}
