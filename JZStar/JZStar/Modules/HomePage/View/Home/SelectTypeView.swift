//
//  SelectTypeCell.swift
//  JZStar
//
//  Created by don on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class SelectTypeView: UIView {
    private let scrollview = TitleScrollView()
    private var titles = [String]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitles(_ titles:[String]){
        scrollView.setRoomsAndSelectedIndex(rooms: titles) { (title) in
            print(title)
        }
    }
    
    lazy var scrollView:TitleScrollView = {
        let view = TitleScrollView()
        return view
    }()
    
}
