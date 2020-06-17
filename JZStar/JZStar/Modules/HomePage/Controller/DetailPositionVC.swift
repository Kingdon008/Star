//
//  DetailPositionVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailPositionVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var positionId:Int?
    var viewModel = DetailPositionVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        setupview()
        // Do any additional setup after loading the view.
        setupData()
    }

    func setupview(){
        navView.setTitle(title: "职位详情")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
    }
    
    func setupData(){
        viewModel.tableViewDataModel.targetTableView(myTableview: tableView)
        viewModel.positionId = positionId
        viewModel.setData {
            self.tableView.reloadData()
        }
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: kStatusBarH, width: kScreenWidth, height: kNavigationBarH)
        let view = NavView(frame: frame)
//        view.backgroundColor = UIColor.red
        return view
    }()

}

