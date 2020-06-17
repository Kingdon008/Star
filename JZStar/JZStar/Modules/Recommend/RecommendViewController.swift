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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "推荐精选"
        tableview = UITableView(frame: CGRect(x: 0, y: kNavigationH, width: kScreenWidth, height: kScreenHeight - 88))
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
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension RecommendViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RecommendDetailCell.initWithXIb() as! RecommendDetailCell
        if let model = self.dataArr?[indexPath.row]{
            let url = URL(string: model.show_img_url)
            cell.icon.kf.setImage(with: url)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}
