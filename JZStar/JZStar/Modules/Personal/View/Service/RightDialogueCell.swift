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
        let maxWidth = kScreenWidth - 90 - 60 - 40
        let dialogueTextRect = String.ss.getTextRectSize(text: dialogue,font: font,size: CGSize.init(width: maxWidth, height: kScreenHeight))
        var dialogueWidth:CGFloat = 0
        var dialogueHeight:CGFloat = 0
        if dialogueTextRect.width <  maxWidth{
            dialogueWidth = dialogueTextRect.width
            dialogueHeight = dialogueTextRect.height
        }else{
            dialogueWidth = maxWidth
            dialogueHeight = dialogueTextRect.height
        }
        
        let defaultServiceIcon = UIImageView()
        defaultServiceIcon.frame = CGRect.init(x: kScreenWidth - 20 - 32, y: 0, width: 32, height: 32)
        let url = URL(string: AppManager.sharedManager.user.headimgurl)
        defaultServiceIcon.kf.setImage(with: url, placeholder: UIImage.init(named: "defaultHeadIcon_big"))
        contentView.addSubview(defaultServiceIcon)
        
        let dialogueBgWidth = dialogueWidth + 40
        let dialogueBgHeight = dialogueHeight + 16
        let dialogueBg = UIView()
        dialogueBg.frame = CGRect.init(x: kScreenWidth - 64 - dialogueBgWidth, y: 0, width: dialogueBgWidth, height: dialogueBgHeight)
        dialogueBg.backgroundColor = UIColor.red
        dialogueBg.backgroundColor = UIColor.init(hexString: "#FFA300")
        contentView.addSubview(dialogueBg)
        addCorner(conrners: [.topLeft,.bottomRight,.bottomLeft], radius: 20, bgView: dialogueBg,bounds:CGRect.init(x: 0, y: 0, width: dialogueBgWidth, height: dialogueBgHeight))
        
        let dialogueLabel = UILabel.init()
        dialogueLabel.text = dialogue
        dialogueLabel.textColor = UIColor.init(hexString: "#333333")
        dialogueLabel.font = font
        dialogueLabel.numberOfLines = 0
        dialogueBg.addSubview(dialogueLabel)
        dialogueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(20)
            make.width.equalTo(dialogueWidth + 2)
            make.height.equalTo(dialogueHeight)
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
