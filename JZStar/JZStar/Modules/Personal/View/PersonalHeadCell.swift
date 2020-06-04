//
//  PersonalHeadCell.swift
//  JZStar
//
//  Created by don on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class PersonalHeadCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("PersonalHeadCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
}
