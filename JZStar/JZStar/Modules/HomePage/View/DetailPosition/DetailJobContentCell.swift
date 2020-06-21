//
//  DetailJobContentCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/16.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailJobContentCell: UITableViewCell {
    @IBOutlet weak var allStarIcon: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyIcon: UIImageView!
    @IBOutlet weak var qqnumLabel: UILabel!
    @IBOutlet weak var deliverLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var allStarIconConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var allStarIconBg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("DetailJobContentCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    func setData(data:Any){
           if let model = data as? DetailPositionModel{
            companyNameLabel.text = model.company_name ?? ""
            if let companyImageUrl = model.company_icon{
                let url = URL(string: companyImageUrl)
                companyIcon.kf.setImage(with: url)
            }
            deliverLabel.text = model.salary_describe
            contentLabel.text = model.content
            qqnumLabel.text = "QQ:\(model.company_qq ?? "")"
            allStarIconConstraint.constant = (model.company_score ?? 0) / 5.0 * 68
            allStarIconBg.layer.masksToBounds = true
        }
    }
    
}
