//
//  OpinionAndComplaintVC.swift
//  JZStar
//
//  Created by don on 2020/6/18.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class OpinionAndComplaintVC: BaseViewController {
    @IBOutlet weak var opinionBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    let menu = MTPopMenu.sharedPopMenu()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
    }

    func setupview(){
        view.backgroundColor = UIColor.init(hexString: "#F3F3F3")
        navView.setTitle(title: "意见反馈")
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        
        textView.addSubview(placeHolderLabel)
        textView.setValue(placeHolderLabel, forKey: "_placeholderLabel")
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.init(hexString: "#C3CBD3").cgColor
        textView.layer.cornerRadius = 8
    }
    
    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarH + kStatusBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
    lazy var placeHolderLabel:UILabel = {
        let view = UILabel()
        view.textColor = STELLAR_COLOR_C6
        view.text = "请在此输入"
        view.numberOfLines = 0
        view.font = STELLAR_FONT_T14
        view.sizeToFit()
        return view
    }()
    
    
    @IBAction func changeAction(_ sender: Any) {
        menu.popMenu(anchorView: opinionBtn, titleArray: ["意见","投诉"])
        menu.selectTextColor = .black
        menu.normalTextColor = .black
        menu.menuBgColor = .lightGray
        menu.didSelectItem = { (index, model) in
            self.opinionBtn.setTitle(model.title ?? "", for: .normal)
        }
    }
    
    @IBAction func submitClick(_ sender: Any) {
        var type:Int?
        if self.opinionBtn.titleLabel?.text == "意见" {
            type = 1
        }else if self.opinionBtn.titleLabel?.text == "投诉" {
            type = 2
        }
        guard let ideaType = type else {
            return
        }
        Network.request(.usercenterIdea(type: ideaType, content: textView.text,uid:"ababababab"), success: { (json) in
            let status = json["status"].intValue
            if status == 1{
                print("成功")
            }else{
                print("失败")
            }
        }) { (error, mess) in
            
        }
    }
}
