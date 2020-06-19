//
//  BHJPickerView.swift
//  BHJPickerView
//
//  Created by 白华君 on 2018/5/21.
//  Copyright © 2018年 baihuajun. All rights reserved.
//

import UIKit



/// PickerDelegate
protocol PickerDelegate {
    
    func selectedGender(_ pickerView : BHJPickerView,_ seleStr : String)
}


class BHJPickerView: UIView , UIPickerViewDelegate, UIPickerViewDataSource{
    var pickerDelegate : PickerDelegate?
    private let pickerH : CGFloat! = 260 * (kScreenHeight / 667)
    private var genderPicker : UIPickerView = UIPickerView()
    private var backgroundButton : UIButton = UIButton()
    private var dataArray = [String]()
    private var selectedGender : String = String()
    
    // MARK: - 初始化UI
    init(_ delegate : PickerDelegate){
        dataArray.removeAll()
        pickerDelegate = delegate
        let frame = CGRect.init(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight)
        super.init(frame: frame)
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        view.backgroundColor = UIColor.white
        self.addSubview(view)
        
        // 取消按钮
        let cancelButton = UIButton.init(type: .custom)
        cancelButton.frame = CGRect.init(x: 0, y: 0, width: 60, height: 44)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        self.addSubview(cancelButton)
        
        // 确定按钮
        let doneButton = UIButton.init(type: .custom)
        doneButton.frame = CGRect.init(x: kScreenWidth - 60, y: 0, width: 60, height: 44)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneButton.setTitle("确定", for: .normal)
        doneButton.setTitleColor(UIColor.black, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        self.addSubview(doneButton)
        
        backgroundButton = UIButton.init(type: .system)
        backgroundButton.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        backgroundButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundButton.addTarget(self, action: #selector(cancelButtonClick), for: .touchUpInside)
        genderPicker = UIPickerView.init(frame: CGRect.init(x: 0, y: 44, width: kScreenWidth, height: pickerH - 44))
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.backgroundColor = UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        self.addSubview(genderPicker)
        dataArray = ["男","女"]
        self.pickerView(genderPicker, didSelectRow: 0, inComponent: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Method
    
    func setData(arr:[String]){
        dataArray = arr
        genderPicker.reloadComponent(0)
    }
    
    /// 取消按钮点击方法
    @objc func cancelButtonClick(){
        
        self.pickerViewHidden()
    }
    
    /// 确定按钮点击方法
    @objc func doneButtonClick(){
        pickerDelegate?.selectedGender(self, selectedGender)
        self.pickerViewHidden()
    }
    
    /// 展示pickerView
    public func pickerViewShow() {
        self.pickerView(genderPicker, didSelectRow: 0, inComponent: 0)
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self.backgroundButton)
        keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.frame.origin.y = kScreenHeight - self.pickerH
        }) { (complete: Bool) in
            
        }
    }
    /// 隐藏pickerView
    public func pickerViewHidden() {
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundButton.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.frame.origin.y = kScreenHeight
        }) { (complete:Bool) in
            self.removeFromSuperview()
            self.backgroundButton.removeFromSuperview()
        }
    }
    
    // MARK: - UIPickerViewDelegate, UIPickerViewDataSource
    
    /// 返回列
    ///
    /// - Parameter pickerView: pickerView
    /// - Returns: 列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// 返回对应列的行数
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - component: 列
    /// - Returns: 行
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    /// 返回对应行的title
    ///
    /// - Parameters:
    ///   - pickerView: pickerView
    ///   - row: 行
    ///   - component: 列
    /// - Returns: title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title = ""
        title = dataArray[row]
        return title
    }
    
    /// 选择列、行
    ///
    /// - Parameters:
    ///   - pickerView: pickerV/   - row: 行
    ///   - component: 列
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = dataArray[row]
    }
}







