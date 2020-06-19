//
//  MainViewController.swift
//  JZStar
//
//  Created by don on 2019/5/31.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

enum ViewState {
    case kVcInit
    case kHomeVc
    case kRecommendVc
    case kPersonalVc
}

class MainViewController: BaseViewController {
    var nextVC = UIViewController()
    var currentVC:UIViewController?
    var myViewState:ViewState = .kVcInit{
        didSet{
            if oldValue == myViewState
            {
                return
            }
            setupController(state: myViewState)
            setupBottomButton(state: myViewState)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubViews()
        myViewState = .kHomeVc
    }
    
    func loadSubViews(){
        loadTabbarView()
    }
    
    func loadTabbarView(){
        view.addSubview(tabbarView)
        tabbarView.snp.makeConstraints {
            $0.left.right.equalTo(self.view)
            $0.bottom.equalTo(0)
            $0.height.equalTo(BOTTOM_TABBAR_HEIGHT + getAllVersionSafeAreaBottomHeight())
        }
        
        let tabbarLineView = UIView()
        tabbarLineView.backgroundColor = STELLAR_COLOR_C9.withAlphaComponent(0.9)
        tabbarView.addSubview(tabbarLineView)
        tabbarLineView.snp.makeConstraints {
            $0.left.right.top.equalTo(tabbarView)
            $0.height.equalTo(0.5)
        }
        
        tabbarView.addSubview(homepageBtn)
        homepageBtn.snp.makeConstraints {
            $0.left.top.bottom.equalTo(tabbarView)
            $0.width.equalTo(kScreenWidth/3.0)
        }
        
        tabbarView.addSubview(recommondBtn)
        recommondBtn.snp.makeConstraints {
            $0.left.equalTo(kScreenWidth/3.0)
            $0.top.bottom.equalTo(1.fit)
            $0.width.equalTo(kScreenWidth/3.0)
        }
        
        tabbarView.addSubview(personBtn)
        personBtn.snp.makeConstraints {
            $0.left.equalTo(kScreenWidth/3.0*2)
            $0.top.bottom.equalTo(1.fit)
            $0.width.equalTo(kScreenWidth/3.0)
        }
        tabbarView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.96)
        
    }
    
    func setupController(state:ViewState){
        switch state {
        case .kVcInit:
            nextVC = homeVC
            break
        case .kHomeVc:
            nextVC = homeVC
            break
        case .kRecommendVc:
            nextVC = recommondVC
            break
        case .kPersonalVc:
            nextVC = personVC
            break
        }
        
        currentVC?.willMove(toParent: self)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
        addChild(nextVC)
        nextVC.didMove(toParent: self)
        view.insertSubview(nextVC.view, belowSubview: self.tabbarView)
        nextVC.view.frame = view.bounds
        currentVC = nextVC
    }
    
    func setupBottomButton(state:ViewState){
        switch state {
        case .kVcInit:
            homepageBtn.isSelected = true
            recommondBtn.isSelected = false
            personBtn.isSelected = false
        case .kHomeVc:
            homepageBtn.isSelected = true
            recommondBtn.isSelected = false
            personBtn.isSelected = false
        case .kRecommendVc:
            homepageBtn.isSelected = false
            recommondBtn.isSelected = true
            personBtn.isSelected = false
        case .kPersonalVc:
            homepageBtn.isSelected = false
            recommondBtn.isSelected = false
            personBtn.isSelected = true
        }
    }
    
    private func specifyButton(title:String,imageName:String) -> TabbarScaledButton{
        let button = TabbarScaledButton.init(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button .setImage(UIImage(named: imageName), for: .normal)
        button .setImage(UIImage(named: imageName + "_highlighted"), for: .selected)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#000000"), for: .selected)
        button.titleLabel?.font = STELLAR_FONT_T11
        button.addTarget(self, action: #selector(bottomButtonTapped(btn:)), for: .touchUpInside)
        return button
    }
    
    @objc private func bottomButtonTapped(btn:UIButton){
        if btn.tag == 0 {
            myViewState = .kHomeVc
        }else if btn.tag == 1 {
            myViewState = .kHomeVc
        }else if btn.tag == 2 {
            myViewState = .kRecommendVc
        }else if btn.tag == 3 {
            myViewState = .kPersonalVc
        }
    }
    
    override var childForStatusBarStyle: UIViewController?
    {
        return currentVC
    }
    
    //MARK:lazy
    lazy var homepageBtn:TabbarScaledButton = {
        let button = specifyButton(title:"主页", imageName: "tabbar_home")
        button.tag = 1
        return button
    }()
    
    lazy var recommondBtn:TabbarScaledButton = {
        let button = specifyButton(title: "推荐", imageName: "tabbar_recommend")
        button.tag = 2
        return button
    }()
    
    lazy var personBtn:TabbarScaledButton = {
        let button = specifyButton(title: "个人中心", imageName: "tabbar_mine")
        button.tag = 3
        return button
    }()
    
    lazy var homeVC:HomePageViewController = {
        let vc = HomePageViewController()
        return vc
    }()
    
    lazy var recommondVC:RecommendViewController = {
        let vc = RecommendViewController()
        return vc
    }()
    
    lazy var personVC:PersonalViewController = {
        let vc = PersonalViewController()
        return vc
    }()
    
    lazy var tabbarView:UIView = {
        let tbView = UIView()
        return tbView
    }()
    
    
}
