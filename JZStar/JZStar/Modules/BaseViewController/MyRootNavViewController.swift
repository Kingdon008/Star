//
//  BaseNavViewController.swift
//  JZStar
//
//  Created by don on 2019/6/26.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class MyRootNavViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var childForStatusBarHidden: UIViewController?{
        return topViewController
    }
    
    override var childForStatusBarStyle: UIViewController?
    {
        guard let topVC = visibleViewController else {
            return topViewController
        }
        guard let childrenVC = topVC.children.first else {
            return topViewController
        }
        if childrenVC.isKind(of: HomePageViewController.classForCoder()) || childrenVC.isKind(of: RecommendViewController.classForCoder()) || childrenVC.isKind(of: PersonalViewController.classForCoder()){
            return childrenVC
        }
        return topViewController
    }
}
