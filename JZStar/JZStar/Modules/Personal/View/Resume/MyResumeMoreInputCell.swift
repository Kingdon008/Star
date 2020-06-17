//
//  MyResumeMoreInputCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumeMoreInputCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("MyResumeMoreInputCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(type:String,text:String? = nil){
        typeLabel.text = type
        if let showTest = text{
            textView.text = showTest
            textView.isUserInteractionEnabled = false
        }
    }
    
}
