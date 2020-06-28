//
//  StellarMineAlertView.swift
//  StellarHomeIOS
//
//  Created by don on 2019/7/1.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class StellarMineAlertView: UIView {
    let disposeBag = DisposeBag()
    var leftClickBlock: (() ->Void)?
    var rightClickBlock: (() ->Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    convenience init(message: String, leftTitle: String, rightTile: String, showExitButton: Bool) {
        self.init(frame: UIScreen.main.bounds)
        setupSubViews(title: nil, message: message, leftTitle: leftTitle, ringhtTitle: rightTile, icon: nil, content: nil)
        setupActions()
    }
    
    private func setupSubViews(title: String?, message: String, leftTitle: String, ringhtTitle: String?, icon: UIImage?, content: String?) {
        let bgViewWidth: CGFloat = 316.fit
        let iconSize = CGSize.zero
        var topSpace = 40.fit
        var iconTitleSpace = 13.fit
        var titleMessageSpace = 12.fit
        var messageLineSpace = 32.fit
        var titleSize = String.ss.getTextRectSize(text: title ?? "", font: STELLAR_FONT_MEDIUM_T17, size: CGSize(width: kScreenWidth-120.fit, height: CGFloat.greatestFiniteMagnitude))
        let messageSize = String.ss.getTextRectSize(text: message, font: STELLAR_FONT_T17, size: CGSize(width: kScreenWidth-120.fit, height: CGFloat.greatestFiniteMagnitude))
        addSubview(bgView)
        bgView.backgroundColor = STELLAR_COLOR_C3
        bgView.layer.cornerRadius = 12.fit
        bgView.clipsToBounds = true
        iconTitleSpace = 0
        titleMessageSpace = 0
        messageLabel.text = message
        topSpace = 38.5.fit
        messageLineSpace = 38.fit
        titleSize = CGRect.zero
        messageLabel.font = STELLAR_FONT_T17
        messageLabel.textColor = STELLAR_COLOR_C4
        setupExitAddDeviceUI(topSpace: topSpace)
        let bgViewHeight = topSpace+iconSize.height+iconTitleSpace+titleSize.height+titleMessageSpace+messageSize.height+messageLineSpace+48.fit
        bgView.center = CGPoint(x: frame.width/2, y: frame.height/2)
        bgView.bounds = CGRect(x: 0, y: 0, width: bgViewWidth, height: bgViewHeight)
        setupBottom(leftTitle: leftTitle, rightTitle: ringhtTitle)
        layoutIfNeeded()
    }
    
    
    
    private func setupExitAddDeviceUI(topSpace: CGFloat) {
        bgView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(bgView).offset(topSpace)
            $0.centerX.equalTo(bgView)
            $0.width.equalTo(kScreenWidth-120.fit)
        }
    }
        
    private func setupBottom(leftTitle: String, rightTitle: String?) {
        let topLine = UIView()
        topLine.isHidden = true
        bgView.addSubview(topLine)
        topLine.backgroundColor = STELLAR_COLOR_C8
        topLine.snp.makeConstraints {
            $0.bottom.equalTo(bgView).offset(-48.fit)
            $0.height.equalTo(1)
            $0.centerX.equalTo(bgView)
            $0.width.equalTo(bgView)
        }
        let lineCenter = UIView.init()
        lineCenter.isHidden = true
        lineCenter.backgroundColor = STELLAR_COLOR_C8
        bgView.addSubview(lineCenter)
        lineCenter.snp.makeConstraints {
            $0.bottom.equalTo(bgView)
            $0.top.equalTo(topLine.snp.bottom)
            $0.centerX.equalTo(bgView)
            $0.width.equalTo(1)
        }
        bgView.addSubview(cancleBtn)
        bgView.addSubview(confirmBtn)
        confirmBtn.setTitle(rightTitle, for: .normal)
        cancleBtn.layer.borderWidth = 1
        cancleBtn.layer.borderColor = UIColor.init(hexString: "#CCCCCC").cgColor
        cancleBtn.layer.cornerRadius = 8
        cancleBtn.snp.makeConstraints {
            $0.width.equalTo(128)
            $0.right.equalTo(lineCenter).offset(-8)
            $0.top.equalTo(topLine)
            $0.height.equalTo(44)
        }
        confirmBtn.layer.cornerRadius = 8
        confirmBtn.snp.makeConstraints {
            $0.width.equalTo(128)
            $0.left.equalTo(lineCenter).offset(8)
            $0.top.equalTo(topLine)
            $0.height.equalTo(44)
        }
        cancleBtn.setTitle(leftTitle, for: .normal)
    }
    
    private func setupActions() {
        cancleBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.leftClickBlock?()
            self?.dissmiss()
        }).disposed(by: disposeBag)
        confirmBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.rightClickBlock?()
            self?.dissmiss()
        }).disposed(by: disposeBag)
        exitButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.dissmiss()
        }).disposed(by: disposeBag)
    }
    
    func show() {
        getKeyboardWindow().addSubview(self)
        bgView.pop_add(self.ss.popScaleAnimation(), forKey: "scale")
    }
    
    private func dissmiss() {
        self.subviews.forEach { (subView) in
            subView.removeFromSuperview()
        }
        self.removeFromSuperview()
    }
    
    private lazy var iconImg: UIImageView = { // 图片
        let tempView = UIImageView.init()
        return tempView
    }()
    
    private lazy var bgView: UIView = { // 白色背景
        let tempView = UIView.init()
        return tempView
    }()
    
    private lazy var titleLabel: UILabel = { // 标题
        let tempView = UILabel.init()
        tempView.font = STELLAR_FONT_MEDIUM_T20
        tempView.textColor = STELLAR_COLOR_C4
        tempView.textAlignment = .center
        return tempView
    }()
    
    private lazy var messageLabel: UILabel = { // 内容
        let tempView = UILabel.init()
        tempView.font = STELLAR_FONT_T15
        tempView.textColor = STELLAR_COLOR_C6
        tempView.numberOfLines = 0
        tempView.textAlignment = .center
        return tempView
    }()
    
    private lazy var cancleBtn: UIButton = {
        let tempView = UIButton.init(type: .custom)
        tempView.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tempView.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        return tempView
    }()
    
    private lazy var confirmBtn: UIButton = {
        let tempView = UIButton.init(type: .custom)
        tempView.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tempView.setTitleColor(UIColor.white, for: .normal)
        tempView.backgroundColor = UIColor.init(hexString: "#070707")
        return tempView
    }()
    
    private lazy var exitButton: UIButton = { // 关闭按钮
        let tempView = UIButton.init(type: .custom)
        tempView.setImage(UIImage(named: "icon_close_gray"), for: .normal)
        return tempView
    }()
}
