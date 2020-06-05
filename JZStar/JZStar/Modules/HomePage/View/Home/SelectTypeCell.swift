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
    private var titles = [String]()
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("SelectTypeCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(30)
        }
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
            self.scrollView.setRoomsAndSelectedIndex(rooms: titles) { (title) in
                print(title)
            }
        }
    }
    
    lazy var scrollView:TitleScrollView = {
        let view = TitleScrollView()
        return view
    }()
    
}
