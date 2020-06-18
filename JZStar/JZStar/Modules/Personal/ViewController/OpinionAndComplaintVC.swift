//
//  OpinionAndComplaintVC.swift
//  JZStar
//
//  Created by don on 2020/6/18.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class OpinionAndComplaintVC: BaseViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
