//
//  DetailJobContentCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/16.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailJobContentCell: UITableViewCell {
    @IBOutlet weak var allStarIcon: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyIcon: UIImageView!
    @IBOutlet weak var qqnumLabel: UILabel!
    @IBOutlet weak var deliverLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var allStarIconConstraint: NSLayoutConstraint!
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var allStarIconBg: UIView!
    var detailPositionModel:DetailPositionModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        copyBtn.layer.borderWidth = 1
        copyBtn.layer.borderColor = UIColor.black.cgColor
        copyBtn.layer.cornerRadius = 2
        copyBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        
        connectBtn.layer.borderWidth = 1
        connectBtn.layer.borderColor = UIColor.init(hexString: "#FFA300").cgColor
        connectBtn.layer.cornerRadius = 2
        connectBtn.backgroundColor = UIColor(red: 1, green: 0.64, blue: 0, alpha: 0.1)
    }
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("DetailJobContentCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    func setData(data:Any){
           if let model = data as? DetailPositionModel{
            self.detailPositionModel = model
            companyNameLabel.text = model.company_name ?? ""
            if let companyImageUrl = model.company_icon{
                let url = URL(string: companyImageUrl)
                companyIcon.kf.setImage(with: url, placeholder: UIImage.init(named: "companyIcon_gray"))
            }
            deliverLabel.text = "\(model.resume_delivery_num ?? "")份投递"
//            contentLabel.text = model.content
            let html = model.content ?? ""
            do {
                if let tempData = html.data(using: String.Encoding.unicode, allowLossyConversion: true) {
                    let attStr = try NSAttributedString.init(data: tempData, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,], documentAttributes: nil)
                    let tempStr = attStr.string
                    if let data = tempStr.data(using: String.Encoding.unicode, allowLossyConversion: true) {
                        let attStr = try NSAttributedString.init(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,], documentAttributes: nil)
                        print("\(attStr.string)")
                        contentLabel.attributedText = attStr
                    }
                }
            } catch {
                contentLabel.text = html
            }
            
            
            

            qqnumLabel.text = "QQ:\(model.company_qq ?? "")"
            allStarIconConstraint.constant = (model.company_score ?? 0) / 5.0 * 68
            allStarIconBg.layer.masksToBounds = true
        }
    }
    
    @IBAction func copyAction(_ sender: Any) {
        let pas = UIPasteboard.general
        pas.string = self.detailPositionModel?.company_qq ?? ""
    }
    
}
