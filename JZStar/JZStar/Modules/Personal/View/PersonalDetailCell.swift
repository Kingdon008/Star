//
//  PersonalDetailCell.swift
//  JZStar
//
//  Created by don on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

enum PersonalListType {
    case myJob
    case service
    case comments
    case aboutUs
    case loginOut
}

class PersonalDetailCell: UITableViewCell {
    var type:PersonalListType?
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("PersonalDetailCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    func setType(type:PersonalListType){
        self.type = type
        if type == .myJob {
            nameLabel.text = "我的职位"
            icon.image = UIImage.init(named: "personal_aboutus")
        }else if type == .service {
            nameLabel.text = "我的客服中心"
            icon.image = UIImage.init(named: "personal_service")
        }else if type == .comments {
            nameLabel.text = "意见投诉"
            icon.image = UIImage.init(named: "personal_comment")
        }else if type == .aboutUs {
            nameLabel.text = "关于我们"
            icon.image = UIImage.init(named: "personal_aboutus")
        }else if type == .loginOut {
            nameLabel.text = "退出登录"
            icon.image = UIImage.init(named: "personal_loginout")
        }
    }
    
}
