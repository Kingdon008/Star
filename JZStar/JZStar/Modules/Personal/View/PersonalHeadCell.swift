//
//  PersonalHeadCell.swift
//  JZStar
//
//  Created by don on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class PersonalHeadCell: UITableViewCell {
    @IBOutlet weak var icon: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var earningsLabel: UILabel!
    @IBOutlet weak var earingsBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("PersonalHeadCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    func setData(data:Any){
        if let model = data as? AppUser{
            setProfit(price: model.profit ?? "")
            nameLabel.text = model.name
            let url = URL(string: model.headimgurl)
            icon.imageView?.kf.setImage(with: url, placeholder: UIImage.init(named: "defaultHeadIcon_big"))
        }
    }
    
    private func setProfit(price:String){
        earingsBG.layer.borderWidth = 1
        earingsBG.layer.borderColor = UIColor.init(hexString: "#070707").cgColor
        
        earningsLabel.numberOfLines = 2
        earningsLabel.textAlignment = .center
        let priceStr = "\(price)元"
        let priceAttribute = [NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "#FF5858"),NSAttributedString.Key.font:STELLAR_FONT_MEDIUM_T16]
        
        let hintStr = "\n今日收益"
        let hintAttribute = [NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "#070707"),NSAttributedString.Key.font:STELLAR_FONT_MEDIUM_T8]
        
        let myAttrString = NSMutableAttributedString(string: priceStr, attributes: priceAttribute)
        let myHintAttrString = NSAttributedString(string: hintStr, attributes: hintAttribute)
        myAttrString.append(myHintAttrString)
        earningsLabel.attributedText = myAttrString
        earningsLabel.sizeToFit()
        //        earingsBG.mj_w = 96
        
        earingsBG.layer.cornerRadius = (earningsLabel.mj_h + 5 + 5)/2.0
    }
    
}
