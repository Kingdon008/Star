//
//  RecommendViewController.swift
//  JZStar
//
//  Created by don on 2020/6/1.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class RecommendViewController: BaseViewController {
    var tableview:UITableView?
    var dataArr:[RecommendProductModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navView.setTitle(title: "精品推荐")
        navView.backButton.isHidden = true
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        
        tableview = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY, width: kScreenWidth, height: kScreenHeight - navView.frame.maxY - BOTTOM_TABBAR_HEIGHT - getAllVersionSafeAreaBottomHeight()))
        tableview?.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        if let tb = tableview {
            view.addSubview(tb)
            tb.delegate = self
            tb.dataSource = self
        }
        Network.request(.boutiqueList(limit: 0), success: { (json) in
            self.dataArr = json["data"].arrayObject?.kj.modelArray(RecommendProductModel.self)
            self.tableview?.reloadData()
        }) { (error, message) in
            
        }
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarH + kStatusBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
}


extension RecommendViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 196
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecommendDetailCell.initWithXIb() as! RecommendDetailCell
        if let model = self.dataArr?[indexPath.row]{
            cell.setData(data: model, contentLine: 2)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.dataArr?[indexPath.row] else {
            return
        }
//        if let url = model.show_img_url {
//            jumpTo(url: url)
//        }else{
//            let vc = RecommendDeatailVC()
//            vc.productModel = model
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    
}
