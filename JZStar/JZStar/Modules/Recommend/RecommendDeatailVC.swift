//
//  RecommendDeatailVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/22.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class RecommendDeatailVC: BaseViewController {
    var tableview:UITableView!
    var productID:Int?
    private var productModel:BannerDetailModel?
    var contentHeight:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupData()
    }
    
    
    func setupview(){
        navView.setTitle(title: "内容详情")
        navView.backgroundColor = UIColor.white
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        let tbHeight = kScreenHeight - navView.frame.maxY - getAllVersionSafeAreaBottomHeight()
        tableview = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY, width: kScreenWidth, height: tbHeight))
        tableview.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        tableview.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        Network.request(.cms_cms_content(id: productID ?? -1), success: { (jsonDic) in
            if let status = jsonDic["status"].int,status == 1 {
                self.productModel = jsonDic["data"].dictionaryObject?.kj.model(BannerDetailModel.self)
                self.tableview.reloadData()
            }
            
        }) { (err, msg) in
            
        }
    }
    
    func setupData(){
        self.contentHeight = getViewHeight()
        if contentHeight < kScreenHeight - navView.frame.maxY - (safeAreaBottomHeight ?? 0) {
            tableview.isScrollEnabled = false
            self.contentHeight = kScreenHeight - navView.frame.maxY - (safeAreaBottomHeight ?? 0)
        }
    }
    
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarH + kStatusBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
}


extension RecommendDeatailVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.contentHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecommendDetailCell.initWithXIb() as! RecommendDetailCell
        if let model = self.productModel{
            cell.setData(data: model, contentLine: 0,isShowDscp: false)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func getViewHeight() -> CGFloat{
        let content = self.productModel?.content ?? ""
        print("------\(content)")
        let attrStr = try! NSMutableAttributedString(
            data: (content.data(using: .unicode, allowLossyConversion: true)!),
            options:[.documentType: NSAttributedString.DocumentType.html,
                     .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        let contentHegiht = attrStr.boundingRect(with: CGSize(width:  kScreenWidth - 32 - 32, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).height
        return 20 + 126 + 25 + contentHegiht + 12
    }
}
