//
//  SelectTypeCell.swift
//  JZStar
//
//  Created by don on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class SelectTypeCell: UITableViewCell {
    private let scrollview = UIScrollView()
    private var titles = ["全部","全职","兼职"]
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollview.showsHorizontalScrollIndicator = false
        addSubview(scrollview)
        scrollview.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 60)
            }

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("SelectTypeCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    func setData(data:Any){
        if let model = data as? MerchantModel,let arr = model.data{
            for subview in self.scrollview.subviews{
                subview.removeFromSuperview()
            }
            self.titles.removeAll()
            
            for merchantClassifyModel in arr {
                if let name =  merchantClassifyModel.name{
                    titles.append(name)
                }
            }
            let num = titles.count
            let btnwidth = 100
            scrollview.contentSize = CGSize.init(width: btnwidth*num, height: 60)
            for index in 0...num - 1 {
                let typeBtn = UIButton.init(type: .custom)
                typeBtn.setTitleColor(UIColor.black, for: .normal)
                typeBtn.setTitle(titles[index], for: .normal)
                scrollview.addSubview(typeBtn)
                typeBtn.frame = CGRect(x: index*btnwidth, y: 0, width: btnwidth, height: 60)
            }
        }
    }
    
}
