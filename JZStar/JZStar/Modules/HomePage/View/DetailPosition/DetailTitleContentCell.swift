//
//  DetailTitleContentCell.swift
//  JZStar
//
//  Created by herodon on 2020/7/9.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailTitleContentCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("DetailTitleContentCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(title:String,text:String){
        titleLabel.text = title
        contentLabel.attributedText = text.ss.transformStringToAttributedString()
    }
    
}
