//
//  AboutUsDeatilVC.swift
//  JZStar
//
//  Created by don on 2020/6/18.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class AboutUsDeatilVC: BaseViewController {
    var model:AboutUsModel?
    
    @IBOutlet weak var textview: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        setupData()
    }
    
    
    func setupview(){
        navView.setTitle(title: model?.problem ?? "")
        navView.backgroundColor = UIColor.white
        navView.backclickBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        view.addSubview(navView)
        
        textview.text = model?.answer ?? ""
        textview.isUserInteractionEnabled = false
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor.init(hexString: "#C3CBD3").cgColor
        textview.layer.cornerRadius = 8
    }
    
    func setupData(){
        
    }

    lazy var navView:NavView = {
        let frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kNavigationBarH + kStatusBarH)
        let view = NavView(frame: frame)
        return view
    }()
    
}
