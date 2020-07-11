//
//  SelectDetailViewCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailJobHeadCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var salaryDescribeLabel: UILabel!
    @IBOutlet weak var tagNameBGView: UIView!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("DetailJobHeadCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: kScreenWidth)
    }

    func setData(data:Any){
        if let model = data as? DetailPositionModel{
            titleLabel.text = model.title
            salaryDescribeLabel.text = model.salary_describe
            tagNameBGView.subviews.forEach({ subView in
                subView.removeFromSuperview()
            })
            var labelX:CGFloat = 26
            if let tags1 = model.tag_name?.type1,tags1.count > 0{
                tags1.forEach({ tagName in
                    let name = " \(tagName) "
                    let color = UIColor.init(hexString: "#FFA300")
                    let label = self.createLabel(name: name, color: color)
                    tagNameBGView.addSubview(label)
                    label.snp.makeConstraints {
                        $0.bottom.equalTo(-20)
                        $0.left.equalTo(labelX)
                        $0.height.equalTo(14)
                    }
                    let labelBG = self.createLabelBG(color: color)
                    label.addSubview(labelBG)
                    labelBG.snp.makeConstraints {
                        $0.left.right.top.bottom.equalTo(0)
                    }
                    let buttonRect = String.ss.getTextRectSize(text: name,font: UIFont.systemFont(ofSize: 10),size: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 22.fit))
                    let width = buttonRect.size.width
                    labelX = labelX + width + 8
                })
            }
            
            if let tags2 = model.tag_name?.type2,tags2.count > 0{
                tags2.forEach({ tagName in
                    let name = " \(tagName) "
                    let color = UIColor.init(hexString: "#5EADEF")
                    let label = self.createLabel(name: name, color: color)
                    tagNameBGView.addSubview(label)
                    label.snp.makeConstraints {
                        $0.bottom.equalTo(-20)
                        $0.left.equalTo(labelX)
                        $0.height.equalTo(14)
                    }
                    let labelBG = self.createLabelBG(color: color)
                    label.addSubview(labelBG)
                    labelBG.snp.makeConstraints {
                        $0.left.right.top.bottom.equalTo(0)
                    }
                    let buttonRect = String.ss.getTextRectSize(text: name,font: UIFont.systemFont(ofSize: 10),size: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 22.fit))
                    let width = buttonRect.size.width
                    labelX = labelX + width + 8
                })
            }
            
            if let isfulltime = model.is_fulltime,isfulltime {
                let name = " 全职 "
                let color = UIColor.init(hexString: "#333333")
                let label = self.createLabel(name: name, color: color)
                tagNameBGView.addSubview(label)
                label.snp.makeConstraints {
                    $0.bottom.equalTo(-20)
                    $0.left.equalTo(labelX)
                    $0.height.equalTo(14)
                }
                let labelBG = self.createLabelBG(color: color)
                label.addSubview(labelBG)
                labelBG.snp.makeConstraints {
                    $0.left.right.top.bottom.equalTo(0)
                }
                let buttonRect = String.ss.getTextRectSize(text: name,font: UIFont.systemFont(ofSize: 10),size: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 22.fit))
                let width = buttonRect.size.width
                labelX = labelX + width + 8
            }
            
            if let is_parttime = model.is_parttime,is_parttime{
                let name = " 兼职 "
                let color = UIColor.init(hexString: "#333333")
                let label = self.createLabel(name: name, color: color)
                tagNameBGView.addSubview(label)
                label.snp.makeConstraints {
                    $0.bottom.equalTo(-20)
                    $0.left.equalTo(labelX)
                    $0.height.equalTo(14)
                }
                let labelBG = self.createLabelBG(color: color)
                label.addSubview(labelBG)
                labelBG.snp.makeConstraints {
                    $0.left.right.top.bottom.equalTo(0)
                }
                let buttonRect = String.ss.getTextRectSize(text: name,font: UIFont.systemFont(ofSize: 10),size: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 22.fit))
                let width = buttonRect.size.width
                labelX = labelX + width + 8
            }
            
        }
    }
    
    private func createLabel(name:String,color:UIColor) -> UILabel{
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 1
        label.layer.borderColor = color.withAlphaComponent(0.1).cgColor
        label.layer.masksToBounds = true
        label.text = name
        label.sizeToFit()
        label.textColor = color
        return label

    }
    
    private func createLabelBG(color:UIColor) -> UIView{
        let bgLayer = UIView()
        bgLayer.backgroundColor = color.withAlphaComponent(0.1)
        return bgLayer
    }
    
}
