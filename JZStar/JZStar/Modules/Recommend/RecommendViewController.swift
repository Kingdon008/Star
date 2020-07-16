//
//  RecommendViewController.swift
//  JZStar
//
//  Created by don on 2020/6/1.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class RecommendViewController: BaseViewController {
    var tableview:UITableView!
    var dataArr:[RecommendProductModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        navView.setTitle(title: "精品推荐")
        navView.backButton.isHidden = true
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        
        tableview = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY, width: kScreenWidth, height: kScreenHeight - navView.frame.maxY - BOTTOM_TABBAR_HEIGHT - getAllVersionSafeAreaBottomHeight()))
        tableview.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        tableview.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            Network.request(.boutiqueList(limit: 0), success: { (json) in
                self.tableview.mj_header?.endRefreshing()
                if let status = json["status"].int,status == 1 {
                    self.dataArr = json["data"].arrayObject?.kj.modelArray(RecommendProductModel.self)
                    self.tableview.reloadData()
                }

            }) { (error, message) in
                self.tableview.mj_header?.endRefreshing()
            }
        })
        Network.request(.boutiqueList(limit: 0), success: { (json) in
            if let status = json["status"].int,status == 1 {
                self.dataArr = json["data"].arrayObject?.kj.modelArray(RecommendProductModel.self)
                self.tableview.reloadData()
            }

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
        if let model = self.dataArr?[indexPath.row]{
            let str = model.dscp ?? ""
            let contentHegiht = String.ss.getTextRectSize(text: str,font: UIFont.systemFont(ofSize: 12),size: CGSize.init(width: kScreenWidth - 32 - 32, height: CGFloat(MAXFLOAT))).height
//            let attrStr = try! NSMutableAttributedString(
//                data: (str.data(using: .unicode, allowLossyConversion: true)!),
//                options:[.documentType: NSAttributedString.DocumentType.html,
//                         .characterEncoding: String.Encoding.utf8.rawValue],
//                documentAttributes: nil)
//            let contentHegiht = attrStr.boundingRect(with: CGSize(width:  kScreenWidth - 32 - 32, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).height
            if contentHegiht >= 28 {
                return 20 + 126 + 8 + 17 + 5 + 28 + 12
            }
            return 20 + 126 + 8 + 17 + 5 + contentHegiht + 12
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecommendDetailCell.initWithXIb() as! RecommendDetailCell
        if let model = self.dataArr?[indexPath.row]{
            cell.setData(data: model, contentLine: 2,isShowDscp: true)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.dataArr?[indexPath.row] else {
            return
        }
        if let url = model.source_url {
            jumpTo(url: url)
        }else{
            let vc = RecommendDeatailVC()
            vc.productModel = model
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
