//
//  PhoneNumView.swift
//  StellarHomeIOS
//
//  Created by don on 2019/5/28.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit
import CountryPickerView

class StellarPhoneTextFieldView: UIView {
    let _bag: DisposeBag = DisposeBag()
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var bottonLabel: UILabel!
    struct Input {
        let textfieldInput: Observable<String>
    }
    struct Output {
        var textFieldValidateResult: Observable<ValidateResult>!
    }
    
    class func stellarPhoneTextFieldView() ->StellarPhoneTextFieldView {
        let view = Bundle.main.loadNibNamed("StellarPhoneTextFieldView", owner: nil, options: nil)?.last as! StellarPhoneTextFieldView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setValidateResult()
    }
    
    func setupView(){
        lineView.backgroundColor = STELLAR_COLOR_C1
        let placeholserAttributes = [NSAttributedString.Key.foregroundColor:STELLAR_COLOR_C6,NSAttributedString.Key.font:STELLAR_FONT_T17]
        textfield.font = UIFont.systemFont(ofSize: 17)
        textfield.attributedPlaceholder = NSAttributedString(string: "请输入手机号",attributes: placeholserAttributes)
        textfield.textColor = STELLAR_COLOR_C4
        textLabel.text = "请输入手机号"
        textLabel.font = STELLAR_FONT_T12
        textLabel.textColor = STELLAR_COLOR_C1
        textLabel.alpha = 0
        bottonLabel.font = STELLAR_FONT_T12
        bottonLabel.textColor = STELLAR_COLOR_C2
        bottonLabel.alpha = 0
        addSubview(countryCodeControl)
        countryCodeControl.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(textfield.snp.centerY)
            make.height.equalTo(36)
            make.width.equalTo(80)
        }
        countryCodeControl.addSubview(countryCodeButton)
        countryCodeButton.snp.makeConstraints { (make) in
            make.left.equalTo(6)
            make.centerY.equalTo(textfield.snp.centerY)
            make.height.equalTo(16)
            make.right.equalTo(-6)
        }
        countryCodeControl.addTarget(self, action: #selector(changeCountryCode), for: .touchUpInside)
    }
    
    func setValidateResult(){
        let input = Input.init(textfieldInput: textfield.rx.value.orEmpty.asObservable())
        var output = Output()
        output.textFieldValidateResult = input.textfieldInput
            .flatMapLatest { (textfieldInput) -> Observable<ValidateResult> in
                return ValidateService.validateUserPhoneNum(userPhoneNum: textfieldInput,region: self.countryCodeButton.selectedCountry.code)
            }
            .share(replay: 1)
        output.textFieldValidateResult.subscribe { [weak self] (event: Event<ValidateResult>) in
            switch event{
            case .completed:return
            case .error(_): break
            case .next(let result):
                switch result{
                case .ok:
                    UIView.animate(withDuration: 0.5, animations: {
                        self?.bottonLabel.alpha = 0
                    })
                    break
                case .failed(let reason):
                    switch reason{
                    case .emptyInput:
                        self?.lineView.backgroundColor = STELLAR_COLOR_C8
                        UIView.animate(withDuration: 0.5, animations: {
                            self?.textLabel.alpha = 0
                            self?.bottonLabel.alpha = 0
                        })
                        break
                    case .other(let msg):
                        self?.lineView.backgroundColor = STELLAR_COLOR_C1
                        UIView.animate(withDuration: 0.5, animations: {
                            self?.textLabel.alpha = 1
                            self?.bottonLabel.alpha = 1
                        })
                        self?.bottonLabel.text = msg
                        break
                    }
                }
            }
            }.disposed(by: _bag)
    }
    
    @objc private func changeCountryCode() {
        countryCodeButton.showCountriesList(from: (parentViewController())!)
    }
    
    private func parentViewController() -> UIViewController? {
        var n = self.next
        while n != nil {
            if (n is UIViewController) {
                return n as? UIViewController
            }
            n = n?.next
        }
        return nil
    }
    
    /// 国家代码
    lazy var countryCodeButton: CountryPickerView = {
        let tempView = CountryPickerView.init()
        tempView.dataSource = self
        tempView.delegate = self
        tempView.countryDetailsLabel.font = STELLAR_FONT_BOLD_T14
        tempView.countryDetailsLabel.textColor = STELLAR_COLOR_C4
        tempView.showCountryCodeInView = false
        tempView.setCountryByName("China")
        tempView.isUserInteractionEnabled = false
        return tempView
    }()
    
    lazy var countryCodeControl: UIControl = {
        let tempView = UIControl.init()
        tempView.layer.borderColor = STELLAR_COLOR_C8.cgColor
        tempView.layer.borderWidth = 1
        tempView.layer.cornerRadius = 18
        return tempView
    }()
}

extension StellarPhoneTextFieldView:CountryPickerViewDataSource,CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        textfield.sendActions(for: .valueChanged)
    }
}
