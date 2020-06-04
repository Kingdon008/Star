//
//  UIButton+indicator.swift
//  JZStar
//
//  Created by don on 2019/7/15.
//  Copyright © 2019 don. All rights reserved.
//

import NVActivityIndicatorView

private struct IndicatorKeys {
    static var managerKey = "stellar_nv_indicator"
}

extension UIButton: SSCompatible {}
extension SS where Base:UIButton{
private var nvIndicator : NVActivityIndicatorView? {
    get{
        if let accpetEventInterval = objc_getAssociatedObject((base as UIButton), &IndicatorKeys.managerKey) as? NVActivityIndicatorView {
            return accpetEventInterval
        }else{
            return nil
        }
    }
    set{
        objc_setAssociatedObject((base as UIButton), &IndicatorKeys.managerKey, newValue as NVActivityIndicatorView?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
    
    mutating func startNVIndicator(color: UIColor) {
        if nvIndicator == nil{
            nvIndicator = NVActivityIndicatorView.init(frame: (base as UIButton).imageView?.frame ?? CGRect.zero, type: .circleStrokeSpin, color: color, padding: nil)
            (base as UIButton).addSubview(nvIndicator!)
            (base as UIButton).bringSubviewToFront(nvIndicator!)
        }
        (base as UIButton).isEnabled = false
        nvIndicator?.color = color
        nvIndicator?.isHidden = false
        nvIndicator?.startAnimating()
//                delay(5) { [weak self] in
//                    self?.stopNVIndicator()
//                }
    }
    
    func stopNVIndicator() {
        (base as UIButton).isEnabled = true
        nvIndicator?.isHidden = true
        nvIndicator?.stopAnimating()
    }
    
    
    func startActivityIndicator() {//菊花
        let button = (base as UIButton)
        button.setTitle("", for: .normal)
        button.setImage(nil, for: .normal)
        button.isUserInteractionEnabled = false
        let indicator = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        indicator.center = CGPoint.init(x: button.bounds.size.width/2, y: button.bounds.size.height/2)
        indicator.tag = 100
        indicator.color = STELLAR_COLOR_C1//self.titleLabel?.textColor
        indicator.startAnimating()
        button.addSubview(indicator)
        button.bringSubviewToFront(indicator)
    }
    
    func stopActivityIndicator(isShowImage:Bool = false,isShowTitle:Bool = false) {
        let button = (base as UIButton)
        button.isUserInteractionEnabled = true
        let targetView = button.subviews.first { (view) -> Bool in
            return view.tag == 100
        }
        targetView?.removeFromSuperview()
        let tempImage = button.imageView?.image
        let tempTitle = button.titleLabel?.text
        if isShowImage {
            button.setImage(tempImage, for: .normal)
        }
        if isShowTitle {
            button.setTitle(tempTitle, for: .normal)
        }
    }
}
