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
    var dataArr:[AboutUsModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupData()
    }
    
    
    func setupview(){
        navView.setTitle(title: "关于我们")
        navView.backgroundColor = UIColor.white
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        
        tableview = UITableView(frame: CGRect(x: 0, y: navView.frame.maxY + 12, width: kScreenWidth, height: 252))
        tableview?.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
        tableview?.separatorColor = UIColor.init(hexString: "#C3CBD3")
        tableview?.separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
        if let tb = tableview {
            view.addSubview(tb)
            tb.delegate = self
            tb.dataSource = self
//            view.addSubview(versionLabel)
//            versionLabel.snp.makeConstraints { (make) in
//                make.top.equalTo(tb.snp.bottom)
//                make.centerX.equalTo(tb.snp.centerX)
//            }
        }
    }
    
    func setupData(){
        Network.request(.usercenterAboutus, success: { (json) in
            if let arr = json["data"].arrayObject?.kj.modelArray(AboutUsModel.self){
                self.dataArr = arr
//                for model in arr{
//                    if model.problem == "当前版本"{
//                        self.versionLabel.text = "当前版本V\(model.answer ?? "")"
//                    }
//                }
                self.dataArr = arr.filter({
                    $0.problem != "当前版本"
                })
                self.tableview?.reloadData()
            }
            
        }) { (error, message) in
            
        }
    }
    
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarH + kStatusBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
//    lazy var versionLabel:UILabel = {
//        let view = UILabel()
//        return view
//    }()
    
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
        if let model = self.dataArr?[indexPath.row]{
            cell.leftLabel.attributedText = model.problem?.ss.transformStringToAttributedString()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = dataArr?[indexPath.row]{
            if model.problem == "分享平台" {
                let messageObject = UMSocialMessageObject()
                messageObject.text = model.answer ?? ""
//                messageObject.title = "标题"
                UMSocialManager.default().share(to: .wechatSession, messageObject: messageObject, currentViewController: self) { (data, error) in
                    guard error != nil else{
                        TOAST(message: "分享失败")
                        return
                    }
                    TOAST(message: "分享成功")
                }
            }else{
                let vc = AboutUsDeatilVC()
                vc.model = dataArr?[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
