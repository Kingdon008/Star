//
//  MyResumeMoreInputCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumeMoreInputCell: UITableViewCell {
    let disposeBag = DisposeBag()
    var textClickBlock:((String)->Void)?
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("MyResumeMoreInputCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        textView.addSubview(placeHolderLabel)
        textView.setValue(placeHolderLabel, forKey: "_placeholderLabel")
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.init(hexString: "#C3CBD3").cgColor
        textView.layer.cornerRadius = 8
        textView.rx.text.subscribe { (text) in
            if let textValue = text.element as? String{
                self.textClickBlock?(textValue)
            }
        }.disposed(by: disposeBag)
    }

    func setData(type:String,text:String? = nil,isUserInteractionEnabled:Bool){
        typeLabel.text = type
        if let showTest = text{
            textView.text = showTest
            textView.textColor = UIColor.init(hexString: "#333333")
        }
//        textView.isUserInteractionEnabled = isUserInteractionEnabled
    }
    
    lazy var placeHolderLabel:UILabel = {
        let view = UILabel()
        view.textColor = STELLAR_COLOR_C6
        view.text = "请在此输入"
        view.numberOfLines = 0
        view.font = STELLAR_FONT_T14
        view.sizeToFit()
        return view
    }()
    
}
