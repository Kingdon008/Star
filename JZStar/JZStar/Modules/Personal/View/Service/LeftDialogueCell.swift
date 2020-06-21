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
        let dialogueTextRect = String.ss.getTextRectSize(text: text,font: font,size: CGSize.init(width: 246, height: kScreenHeight))
        var width:CGFloat = 0
        var height:CGFloat = 0
        if dialogueTextRect.width <  246{
            width = dialogueTextRect.width
            height = 20
        }else{
            width = 246
            height = dialogueTextRect.height
        }
        
        let dialogueBg = UIView()
        let dialogueBgWidth = width + 40
        let dialogueBgHeight = height + 16
        dialogueBg.frame = CGRect.init(x: 20, y: 0, width: dialogueBgWidth, height: dialogueBgHeight)
        dialogueBg.backgroundColor = UIColor.red
        dialogueBg.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        contentView.addSubview(dialogueBg)
        addCorner(conrners: [.topLeft,.bottomRight,.topRight], radius: 20, bgView: dialogueBg,bounds:CGRect.init(x: 0, y: 0, width: dialogueBgWidth, height: dialogueBgHeight))

                
        let dialogueLabel = UILabel.init()
        dialogueLabel.text = text
        dialogueLabel.textColor = UIColor.init(hexString: "#333333")
        dialogueLabel.font = font
        dialogueBg.addSubview(dialogueLabel)
        dialogueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(20)
            make.width.equalTo(width+4)
            make.height.equalTo(height)
        }
    }
    
    func addCorner(conrners: UIRectCorner , radius: CGFloat,bgView:UIView,bounds:CGRect) {
        let maskPath = UIBezierPath(roundedRect: bounds,
        byRoundingCorners: conrners, cornerRadii:CGSize(width:radius, height:radius))
        let masklayer = CAShapeLayer()
        masklayer.frame = bounds
        masklayer.path = maskPath.cgPath
        bgView.layer.mask = masklayer
    }
    
}
