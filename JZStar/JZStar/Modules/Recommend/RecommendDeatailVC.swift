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
    var productModel:RecommendProductModel?
    var contentHeight:CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupData()
    }
    
    
    func setupview(){
        navView.setTitle(title: productModel?.title ?? "")
        navView.backgroundColor = UIColor.white
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        let tbHeight = kScreenHeight - navView.frame.maxY - getAllVersionSafeAreaBottomHeight()
        tableview = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY + 12, width: kScreenWidth, height: tbHeight))
        tableview.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        tableview.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
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
            cell.setData(data: model, contentLine: 0)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func getViewHeight() -> CGFloat{
        let content = productModel?.content ?? ""
        let rect = String.ss.getTextRectSize(text: content,font: UIFont.systemFont(ofSize: 12),size: CGSize.init(width: kScreenWidth - 32 - 32, height: 1000))
        return 20 + 126 + 25 + rect.height + 12
    }
}
