//
//  ServiceHeadCell.swift
//  JZStar
//
//  Created by herodon on 2020/6/20.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class ServiceHeadCell: UITableViewCell {
    private let disposeBag: DisposeBag = DisposeBag()
    var dataArr = [AboutUsModel]()
    var titleClickBlock:((AboutUsModel)->Void)?
    static func initWithXIb() -> UITableViewCell{
        let arrayOfViews = Bundle.main.loadNibNamed("ServiceHeadCell", owner: nil, options: nil)
        guard let firstView = arrayOfViews?.first as? UITableViewCell else {
            return UITableViewCell()
        }
        return firstView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.init(hexString: "#F3F3F3")
        bgView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: -5)
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowRadius = 16
        
        addSubview(bgView)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.snp.makeConstraints { (make) in
            make.top.equalTo(25)
            make.bottom.equalTo(-40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
    }
    
    func setData(data:Any){
        if let modelArr = data as? [AboutUsModel]{
            
            let topIcon = UIImageView.init()
            bgView.addSubview(topIcon)
            topIcon.image = UIImage.init(named: "service_guess")
            topIcon.snp.makeConstraints { (make) in
                make.width.height.equalTo(44)
                make.top.equalTo(20)
                make.left.equalTo(10)
            }
            var index = 0
            modelArr.forEach({model in
                self.createAsk(model: model, index: index)
                index += 1
            })
            
        }
    }
    
    private func createAsk(model:AboutUsModel,index:Int){
        let askBtn = UIButton.init(type: .custom)
        askBtn.setTitle(model.problem ?? "", for: .normal)
        askBtn.setTitleColor(UIColor.init(hexString: "#333333"), for: .normal)
        askBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        askBtn.rx.tap.subscribe(onNext: { [weak self] (_) in
            self?.titleClickBlock?(model)
        }).disposed(by: disposeBag)
        bgView.addSubview(askBtn)
        askBtn.snp.makeConstraints { (make) in
            make.top.equalTo(4 + 16 + (20 + 16) * index)
            make.left.equalTo(64)
        }
        
        let rightIcon = UIImageView.init()
        bgView.addSubview(rightIcon)
        rightIcon.image = UIImage.init(named: "rightArrow_gray")
        rightIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(12)
            make.right.equalTo(-12)
            make.centerY.equalTo(askBtn.snp.centerY)
        }
    }
    
    
    
    lazy var bgView:UIView = {
        let view = UIView()
        return view
    }()

    private func getHeadHeight() -> CGFloat{
        let tempheight = 25 + 40 + 4 + self.dataArr.count * (16 + 20) + 23
        return CGFloat(tempheight < 162 ? 162 : tempheight)
    }
}
