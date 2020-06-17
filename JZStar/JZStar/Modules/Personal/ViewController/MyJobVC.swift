//
//  MyJobVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyJobVC: BaseViewController {
    var dataArr = [DetailMerchantModel]()
    var tableView:UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.setTitle(title: "我的职位")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        view.addSubview(typeView)
        typeView.setTitles(["已报名","已录取","已参加","已收藏"])
        typeView.selectBlock = { title in
            
        }
        tableView = UITableView(frame: CGRect(x: 0, y: typeView.frame.maxY, width: kScreenWidth, height: kScreenHeight -  typeView.frame.maxY - getAllVersionSafeAreaBottomHeight()))
        if let tb = tableView {
            tb.delegate = self
            tb.dataSource = self
            view.addSubview(tb)
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MyJobVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
        let model = self.dataArr[indexPath.row]
        cell.setData(data: model)
        cell.selectionStyle = .none
        return cell
    }
    
    
}
