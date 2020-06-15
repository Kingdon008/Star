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
    var selectBlock:((String)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.bottom.equalTo(0)
            $0.left.equalTo(0)
            $0.right.equalTo(0)
            $0.top.equalTo(0)
        }
        let line = UIView()
        line.backgroundColor = UIColor.init(hexString: "#C3CBD3")
        self.addSubview(line)
        line.snp.makeConstraints {
            $0.left.bottom.equalTo(0)
            $0.right.equalTo(0)
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitles(_ titles:[String]){
        scrollView.setRoomsAndSelectedIndex(rooms: titles) { (title) in
            self.selectBlock?(title)
        }
    }
    
    lazy var scrollView:TitleScrollView = {
        let view = TitleScrollView()
        return view
    }()
    
}
