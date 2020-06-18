//
//  AboutUsVC.swift
//  JZStar
//
//  Created by don on 2020/6/18.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class AboutUsVC: BaseViewController {
    var tableview:UITableView?
    var dataArr:[RecommendProductModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navView.setTitle(title: "关于我们")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        
        tableview = UITableView(frame: CGRect(x: 0, y: kNavigationH, width: kScreenWidth, height: kScreenHeight - 88))
        tableview?.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        if let tb = tableview {
            view.addSubview(tb)
            tb.delegate = self
            tb.dataSource = self
        }
    }
    lazy var navView:NavView = {
           let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarH + kStatusBarH)
           let view = NavView(frame: frame)
           return view
       }()
}


extension AboutUsVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LeftTitleAndArrowCell.initWithXIb() as! LeftTitleAndArrowCell
//        if let model = self.dataArr?[indexPath.row]{
//            let url = URL(string: model.show_img_url)
//            cell.icon.kf.setImage(with: url)
//        }
        cell.selectionStyle = .none
        return cell
    }
}
