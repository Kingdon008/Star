//
//  BaseViewController.swift
//  StellarHomeIOS
//
//  Created by don on 2019/5/24.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {
    let disposeBag = DisposeBag()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        fd_prefersNavigationBarHidden = true
        view.clipsToBounds = true
    }
    
    deinit {
        print("deinit-------> \(classForCoder)")
    }
}
