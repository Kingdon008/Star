//
//  SelectDetailViewCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class SelectDetailViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var salaryDescribeLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("SelectDetailViewCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 20)
    }

    func setData(data:Any){
        if let model = data as? DetailMerchantModel{
            titleLabel.text = model.title
            salaryDescribeLabel.text = model.salary_describe
            companyNameLabel.text = model.company_name
//            tagLabel.text = model.tag_name
        }
    }
    
}
