//
//  CompleteResumeCell.swift
//  JZStar
//
//  Created by don on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class CompleteResumeCell: UITableViewCell {
    
    @IBOutlet weak var perLabel: UILabel!

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("CompleteResumeCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setPer(per:String){
        if !per.isEmpty {
            perLabel.text = "\(per)%"
        }
    }

    
}
