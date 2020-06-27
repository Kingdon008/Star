//
//  MyResumeInputCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumeInputCell: UITableViewCell {
    let disposeBag = DisposeBag()
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    var textClickBlock:((String)->Void)?
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("MyResumeInputCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    func setData(type:String,text:String? = nil){
        typeLabel.text = type
        if let showTest = text{
            textfield.text = showTest
//            textfield.isUserInteractionEnabled = false
            textfield.textColor = UIColor.init(hexString: "#333333")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        textfield.placeholder = "请输入"
        textfield.rx.text.subscribe { (text) in
            if let textValue = text.element as? String{
                self.textClickBlock?(textValue)
            }
        }.disposed(by: disposeBag)
    }
}
