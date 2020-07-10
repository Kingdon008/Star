//
//  MyResumePickUpCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumePickUpCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var detailShowLabel: UILabel!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("MyResumePickUpCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        detailShowLabel.text = "请选择"
    }
    
    func setData(type:String,text:String? = nil){
        typeLabel.text = type
        if let showTest = text,!showTest.isEmpty{
            detailShowLabel.text = showTest
            detailShowLabel.textColor = UIColor.init(hexString: "#333333")
        }
    }
}
