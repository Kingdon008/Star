//
//  RecommendDetailCell.swift
//  JZStar
//
//  Created by don on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class RecommendDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("RecommendDetailCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func setData(data:Any,contentLine:Int,isShowDscp:Bool){
        if let model = data as? RecommendProductModel{
            let url = URL(string: model.show_img_url)
            icon.kf.setImage(with: url)
            titleLabel.text = model.title
            if isShowDscp {
                contentLabel.text = model.dscp
                titleLabel.text = model.title
            }else{
                let str = model.title ?? ""
                let attributedString = NSMutableAttributedString(string:str)
                attributedString.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(hexString: "#333333"),NSAttributedString.Key.font: STELLAR_FONT_MEDIUM_T14], range: NSRange.init(location: 0, length: str.count))

                
                titleLabel.attributedText = attributedString
                titleTopConstraint.constant = 18
                titleLabel.textAlignment = .center
                contentLabel.attributedText = model.content?.ss.transformStringToAttributedString()
            }
            contentLabel.numberOfLines = contentLine
            contentLabel.lineBreakMode = .byTruncatingTail
        }
        if let detailModel = data as? BannerDetailModel{
            let url = URL(string: detailModel.show_img_url)
            icon.kf.setImage(with: url)
            titleLabel.text = detailModel.title
            let str = detailModel.title ?? ""
            let attributedString = NSMutableAttributedString(string:str)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(hexString: "#333333"),NSAttributedString.Key.font: STELLAR_FONT_MEDIUM_T14], range: NSRange.init(location: 0, length: str.count))

            
            titleLabel.attributedText = attributedString
            titleTopConstraint.constant = 18
            titleLabel.textAlignment = .center
            contentLabel.attributedText = detailModel.content?.ss.transformStringToAttributedString()
            contentLabel.numberOfLines = contentLine
            contentLabel.lineBreakMode = .byTruncatingTail
        }
        
    }
    
    func getMaxY()->CGFloat{
        return contentLabel.frame.maxY + 12
    }
    
}
