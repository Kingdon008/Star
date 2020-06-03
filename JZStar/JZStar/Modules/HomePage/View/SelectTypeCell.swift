//
//  SelectTypeCell.swift
//  JZStar
//
//  Created by don on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class SelectTypeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let titles = ["全部","1","2"]
        let num = titles.count - 1
        let btnwidth = 60
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        addSubview(scrollview)

        scrollview.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 60)
        scrollview.contentSize = CGSize.init(width: btnwidth*num, height: 60)
        for index in 0...num {
            let typeBtn = UIButton.init(type: .custom)
            typeBtn.setTitleColor(UIColor.black, for: .normal)
            typeBtn.setTitle(titles[index], for: .normal)
            scrollview.addSubview(typeBtn)
            typeBtn.frame = CGRect(x: index*btnwidth, y: 0, width: btnwidth, height: 60)
        }
    }

    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("SelectTypeCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
}
