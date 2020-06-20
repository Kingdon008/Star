//
//  LeftDialogueCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/20.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class LeftDialogueCell: UITableViewCell {

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("LeftDialogueCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.init(hexString: "#F3F3F3")
    }

    func setDialogueText(_ text:String){
        let font = UIFont.systemFont(ofSize: 14)
        let height = String.ss.getTextRectSize(text: text,font: font,size: CGSize.init(width: kScreenWidth - 89 - 40, height: kScreenHeight)).height
        
        let dialogueView = UILabel.init()
        dialogueView.text = text
        dialogueView.textColor = UIColor.init(hexString: "#333333")
        dialogueView.font = font
        contentView.addSubview(dialogueView)
        dialogueView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(40)
            make.width.equalTo(kScreenWidth - 89 - 40)
            make.height.equalTo(height)
        }
    }
    
}
