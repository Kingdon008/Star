//
//  DetailPositionVC.swift
//  JZStar
//
//  Created by herodon on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailPositionVC: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var positionId:Int?
    @IBOutlet weak var collectBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!
    var positionModel:DetailPositionModel?
    var viewModel = DetailPositionVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        setupview()
        // Do any additional setup after loading the view.
        setupData()
    }

    func setupview(){
        navView.setTitle(title: "职位详情")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
    }
    
    func setupData(){
        viewModel.tableViewDataModel.targetTableView(myTableview: tableView)
        guard let currentPositionId = self.positionId  else {
            return
        }
        Network.request(.positionContent(id: currentPositionId), success: { (json) in
            self.positionModel = json["data"].description.kj.model(DetailPositionModel.self)
            self.viewModel.positionModel = self.positionModel
            self.viewModel.setData {
                self.tableView.reloadData()
            }
            if self.viewModel.positionModel?.is_collect ?? false{
                self.collectBtn.setImage(UIImage.init(named: "collect"), for: .normal)
            }
            if self.viewModel.positionModel?.is_signup ?? false{
                self.signupBtn.setTitle("已报名", for: .normal)
            }
        }) { (error, message) in
            
        }
        
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarH + kStatusBarH)
        let view = NavView(frame: frame)
//        view.backgroundColor = UIColor.red
        return view
    }()

    @IBAction func signypAction(_ sender: Any) {
        if let position_id = self.positionModel?.id{
            Network.request(.usercenterSave_position(uid: "ababababab", status_id: 1, position_id: position_id), success: { (json) in
                let isSucc = json["data"].boolValue
                if isSucc{
                    self.viewModel.positionModel?.is_signup = !(self.viewModel.positionModel?.is_signup ?? false)
                    if self.viewModel.positionModel?.is_signup ?? false{
                        self.signupBtn.setTitle("已报名", for: .normal)
                    }else{
                        self.signupBtn.setTitle("立即报名", for: .normal)
                    }
                }
            }) { (error, mess) in
                
            }
        }
    }
        
    
    @IBAction func cooectAction(_ sender: Any) {
        if let position_id = self.positionModel?.id{
            Network.request(.usercenterSave_position(uid: "ababababab", status_id: 4, position_id: position_id), success: { (json) in
                let isSucc = json["data"].boolValue
                if isSucc{
                    self.viewModel.positionModel?.is_collect = !(self.viewModel.positionModel?.is_collect ?? false)
                    if self.viewModel.positionModel?.is_collect ?? false{
                        self.collectBtn.setImage(UIImage.init(named: "collect"), for: .normal)
                    }else{
                        self.collectBtn.setImage(UIImage.init(named: "uncollect"), for: .normal)
                    }
                }
            }) { (error, mess) in
                
            }
        }
    }
}

