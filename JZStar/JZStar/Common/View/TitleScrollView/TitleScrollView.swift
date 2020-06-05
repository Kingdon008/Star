//
//  TitleScrollview.swift
//  StellarHomeIOS
//
//  Created by don on 2019/6/3.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class TitleScrollView: UIView {
    private let buttonSpaceWidth:CGFloat = 15
    private var selectTitleNumBlock:((Int)->Void)? = nil
    private var needJumpBegain:NSInteger = 0
    private var needJumpEnd:NSInteger = 0
    private var selectBeforeBtn:UIButton?

    private var titles:[String] = [""]{
        didSet{
            for view in scrollview.subviews {
                view.removeFromSuperview()
            }
            initViewsWith(titles: titles)
        }
    }
    
    var selectIndex:NSInteger = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollview)
        scrollview.snp.makeConstraints {
            $0.left.right.equalTo(self)
            $0.bottom.equalTo(0)
            $0.top.equalTo(0)
        }
    }
    
    func setRoomsAndSelectedIndex(rooms:[String],selectRoomIndexBlock:((String)->Void)?){
        titles = rooms
        selectTitleNumBlock = { index in
            if self.titles.count > 0{
                self.drawButtonsState()
                selectRoomIndexBlock?(self.titles[index])
            }
        }
        
    }
    
    private func initViewsWith(titles:[String]){
        var contentWidth:CGFloat = 0;
        needJumpBegain = 0
        needJumpEnd = 0
        for i in 0..<titles.count {
            let text = titles[i]
            let button = UIButton.init(type: .custom)
            var buttonFont = STELLAR_FONT_BOLD_T16
            if i == 0 {
                buttonFont = STELLAR_FONT_BOLD_T18
            }
            let buttonRect = String.ss.getTextRectSize(text: text,font: buttonFont,size: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 22.fit))
            let width = buttonRect.size.width + buttonSpaceWidth
            button.setTitle(text, for: .normal)
            button.tag = i+100
            button.titleLabel?.font = STELLAR_FONT_BOLD_T16
            button.setTitleColor(STELLAR_COLOR_C4.withAlphaComponent(0.3), for: .normal)
            button.setTitleColor(UIColor.black, for: .selected)
            button.addTarget(self, action: #selector(selectAction(btn:)), for: .touchUpInside)
            scrollview.addSubview(button)
            button.snp.makeConstraints {
                $0.left.equalTo(contentWidth + 14)
                $0.width.equalTo(width)
                $0.height.equalTo(22)
                $0.centerY.equalTo(self)
            }
            if i==0{
                button.titleLabel?.font = STELLAR_FONT_BOLD_T18
                button.isSelected = true
                selectBeforeBtn = button
            }
            contentWidth = width + contentWidth
            //判断需要滑动的临界值
            if (button.frame.maxX >= kScreenWidth/2.0) && needJumpBegain == 0
            {
                needJumpBegain = i
                needJumpBegain = needJumpBegain>0 ? needJumpBegain+1 : needJumpBegain
            }
        }
        scrollview.contentSize = CGSize.init(width: contentWidth + 20, height: 0)
        for i in 0..<titles.count {
            guard let button = scrollview.viewWithTag(100+i) else{
                break
            }
            if ((scrollview.contentSize.width - button.frame.maxX) <= kScreenWidth/2.0) && needJumpEnd==0 {
                needJumpEnd = i
                needJumpEnd = needJumpEnd>0 ? needJumpEnd-1 : needJumpEnd
            }
        }
    }
    
    @objc func selectAction(btn:UIButton){
            if selectBeforeBtn == nil {
                return
            }
            selectIndex = btn.tag - 100
            selectTitleNumBlock?(selectIndex)
        }
        
    //    func tapActionWith(index:Int,animated:Bool = true){
    //        selectIndex = index
    //        drawButtonsState(animated)
    //    }
    
    private func drawButtonsState(_ animated:Bool = true){
        guard let button = scrollview.viewWithTag(selectIndex+100) as? UIButton else{
            return
        }
        guard let beforeBtn = self.selectBeforeBtn else{
            return
        }
        if scrollview.contentSize.width > kScreenWidth{
            if selectIndex >= needJumpBegain && selectIndex <= needJumpEnd{
                scrollview.setContentOffset(CGPoint.init(x: button.frame.minX + button.bounds.size.width/2.0 - kScreenWidth / 2.0, y: 0), animated: true)
            }
            else if selectIndex < needJumpBegain{
                scrollview.setContentOffset(CGPoint.zero, animated: true)
            }else if selectIndex > needJumpEnd{
                scrollview.setContentOffset(CGPoint.init(x: scrollview.contentSize.width - scrollview.frame.size.width, y: 0), animated: true)
            }
        }
        beforeBtn.titleLabel?.font = STELLAR_FONT_BOLD_T16
        button.titleLabel?.font = STELLAR_FONT_BOLD_T18
        beforeBtn.titleLabel?.sizeToFit()
        if animated {
            UIView.animate(withDuration: 0.3) {
                button.titleLabel?.sizeToFit()
            }
        }else{
            button.titleLabel?.sizeToFit()
        }
        self.selectBeforeBtn?.isSelected = false
        button.isSelected = true
        self.selectBeforeBtn = button
    }
    
    //MARK:lazy
    private lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
}
