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
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("SelectDetailViewCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
