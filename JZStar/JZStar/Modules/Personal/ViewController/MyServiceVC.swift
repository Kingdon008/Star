//
//  MyServiceVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/19.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyServiceVC: BaseViewController {
    
    @IBOutlet weak var textfieldView: UITextField!
    @IBOutlet weak var sendView: UIView!
    
    var tableview:UITableView!
    var viewModel = ServiceVM()
    var dataArr = [AboutUsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
    }
    
    func setupView(){
        navView.setTitle(title: "客服中心")
        navView.backgroundColor = UIColor.white
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        
        tableview = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY, width: kScreenWidth, height: kScreenHeight - navView.frame.maxY - getAllVersionSafeAreaBottomHeight() - 76))
        tableview.contentInsetAdjustmentBehavior = .never
        tableview.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        tableview.separatorColor = UIColor.init(hexString: "#C3CBD3")
        view.addSubview(tableview)
        
        sendView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        sendView.layer.shadowOffset = CGSize(width: 0, height: -5)
        sendView.layer.shadowOpacity = 1
        sendView.layer.shadowRadius = 16
    }
    
    func setupData(){
        viewModel.tableViewDataModel.targetTableView(myTableview: tableview)
//        viewModel.vmDelegate = self
        Network.request(.usercenterCustom_service, success: { (json) in
            self.dataArr = json["data"].arrayObject?.kj.modelArray(AboutUsModel.self) ?? [AboutUsModel]()
            self.viewModel.dataArr = self.dataArr
            self.viewModel.setData {
                self.tableview.reloadData()
            }
        }) { (err, mess) in
            
        }
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: kStatusBarH, width: kScreenWidth, height: kNavigationBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
    @IBAction func sendAction(_ sender: Any) {
        var isSend = false
        dataArr.forEach({
            if $0.problem == self.textfieldView.text{
                self.viewModel.adddialogueView(dia: $0)
                isSend = true
            }
        })
        if !isSend{
            TOAST(message: "没有找到您查找的答案")
        }
    }
}
