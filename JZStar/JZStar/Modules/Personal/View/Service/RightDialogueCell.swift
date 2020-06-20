//
//  RightDialogueCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/20.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class RightDialogueCell: UITableViewCell {

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("RightDialogueCell", owner: nil, options: nil)
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
        let dialogue = "  \(text)  "
        let font = UIFont.systemFont(ofSize: 14)
        let width = String.ss.getTextRectSize(text: dialogue,font: font,size: CGSize.init(width: 246, height: kScreenHeight)).width
        
        let dialogueBg = UIView()
        dialogueBg.frame = CGRect.init(x: kScreenWidth - 13 - width, y: 0, width: width, height: 36)
        dialogueBg.backgroundColor = UIColor.red
        dialogueBg.backgroundColor = UIColor.init(hexString: "#FFA300")
        contentView.addSubview(dialogueBg)
        addCorner(conrners: [.topLeft,.bottomRight,.bottomLeft], radius: 20, bgView: dialogueBg,bounds:CGRect.init(x: 0, y: 0, width: width, height: 36))
        
        let dialogueLabel = UILabel.init()
        dialogueLabel.text = dialogue
        dialogueLabel.textColor = UIColor.init(hexString: "#333333")
        dialogueLabel.font = font
        dialogueLabel.numberOfLines = 1
        dialogueBg.addSubview(dialogueLabel)
        dialogueLabel.snp.makeConstraints { (make) in
            make.center.equalTo(dialogueBg.snp.center)
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
