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
    var tableView:UITableView!
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
        navView.setTitle(title: "我的职位")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        setupdata()
    }
    
    func setupdata(){
        Network.request(.userCenterPosition(uid: (AppManager.sharedManager.user.uid ?? "")), success: { (json) in
            if let status = json["status"].int,status == 1 {
                self.setupview()
                self.jobData = json["data"].arrayObject?.kj.modelArray(MyJobModel.self)
                self.jobData?.forEach({ model in
                    self.titles.append(model.name ?? "")
                })
                self.typeView.setTitles(self.titles)
                self.currentID = self.jobData?.first?.status_id
            }else{
                self.view.addSubview(self.noJobImageView)
                self.view.addSubview(self.noJobLabel)
            }
        }) { (error, message) in
            
        }
    }
    
    func setupview(){
        typeView.selectBlock = { title in
            self.jobData?.forEach({ model in
                if model.name == title{
                    self.currentArr = model.data
                    self.tableView?.reloadData()
                }
            })
        }
        view.addSubview(typeView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: typeView.frame.maxY, width: kScreenWidth, height: kScreenHeight -  typeView.frame.maxY - getAllVersionSafeAreaBottomHeight()))
        tableView?.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    lazy var noJobImageView:UIImageView = {
        let frame = CGRect.init(x: kScreenWidth/2.0 - 171/2.0, y: kScreenHeight/2.0 - 171/2.0, width: 171, height: 171)
        let view = UIImageView(frame: frame)
        view.image = UIImage.init(named: "noJob")
        return view
    }()
    
    lazy var noJobLabel:UILabel = {
        let view = UILabel()
        view.text = "暂无内容"
        view.font = STELLAR_FONT_MEDIUM_T18
        view.textColor = UIColor.init(hexString: "#333333")
        view.sizeToFit()
        let frame = CGRect.init(x: kScreenWidth/2.0 - view.mj_w/2.0, y: noJobImageView.frame.maxY + 27, width: view.mj_w, height: view.mj_h)
        view.frame = frame
        return view
    }()
    
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentModel = currentArr[indexPath.row]
        let vc = DetailPositionVC()
        vc.positionId = currentModel.id
        navigationController?.pushViewController(vc, animated: true)
    }

}
