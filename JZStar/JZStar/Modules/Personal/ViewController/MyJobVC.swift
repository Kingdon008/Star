//
//  MyJobVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyJobVC: BaseViewController {
    var jobData:[MyJobModel]?
    var titles = [String]()
    var tableView:UITableView?
    var currentID:String?{
        didSet{
            jobData?.forEach({ model in
                if model.status_id == currentID{
                    currentArr = model.data
                    self.tableView?.reloadData()
                }
            })
        }
    }
    var currentArr = [DetailMerchantModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupdata()
    }
    
    func setupview(){
        navView.setTitle(title: "我的职位")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        view.addSubview(typeView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: typeView.frame.maxY, width: kScreenWidth, height: kScreenHeight -  typeView.frame.maxY - getAllVersionSafeAreaBottomHeight()))
        tableView?.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        if let tb = tableView {
            tb.delegate = self
            tb.dataSource = self
            view.addSubview(tb)
        }
    }
    
    func setupdata(){
        Network.request(.userCenterPosition(uid: (AppManager.sharedManager.user.uid ?? "")), success: { (json) in
            self.jobData = json["data"].arrayObject?.kj.modelArray(MyJobModel.self)
            self.jobData?.forEach({ model in
                self.titles.append(model.name ?? "")
            })
            self.typeView.setTitles(self.titles)
            self.currentID = self.jobData?.first?.status_id
        }) { (error, message) in
            
        }
        
        typeView.selectBlock = { title in
            self.jobData?.forEach({ model in
                if model.name == title{
                    self.currentArr = model.data
                    self.tableView?.reloadData()
                }
            })
        }
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: kStatusBarH, width: kScreenWidth, height: kNavigationBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
    lazy var typeView:SelectTypeView = {
        let frame = CGRect.init(x: 0, y: navView.frame.maxY, width: kScreenWidth, height: 50)
        let view = SelectTypeView(frame: frame)
        return view
    }()
    
}

extension MyJobVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentArr.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
        let model = self.currentArr[indexPath.row]
        cell.setData(data: model)
        cell.selectionStyle = .none
        return cell
    }


}
