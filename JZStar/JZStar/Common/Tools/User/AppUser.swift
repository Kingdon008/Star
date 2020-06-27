//
//  AppUser.swift
//  JZStar
//
//  Created by don on 2019/7/10.
//  Copyright © 2019 don. All rights reserved.
//

import UIKit

class AppUser: NSObject {
    @objc var uid:String?{
        didSet{
            mDic.updateValue(uid ?? "", forKey: keyAppUser + #keyPath(AppUser.uid))
            isDirty = true
        }
    }
    @objc var name:String?{
        didSet{
            mDic.updateValue(name ?? "", forKey: keyAppUser + #keyPath(AppUser.name))
            isDirty = true
        }
    }
    @objc var sex:String?{
        didSet{
            mDic.updateValue(sex ?? "", forKey: keyAppUser + #keyPath(AppUser.sex))
            isDirty = true
        }
    }
    @objc var age:String?{
        didSet{
            mDic.updateValue(age ?? "", forKey: keyAppUser + #keyPath(AppUser.age))
            isDirty = true
        }
    }
    @objc var education:String?{
        didSet{
            mDic.updateValue(education ?? "", forKey: keyAppUser + #keyPath(AppUser.education))
            isDirty = true
        }
    }
    @objc var major:String?{
        didSet{
            mDic.updateValue(major ?? "", forKey: keyAppUser + #keyPath(AppUser.major))
            isDirty = true
        }
    }
    @objc var interest_profession:String?{
        didSet{
            mDic.updateValue(interest_profession ?? "", forKey: keyAppUser + #keyPath(AppUser.interest_profession))
            isDirty = true
        }
    }
    @objc var personal_description:String?{
        didSet{
            mDic.updateValue(personal_description ?? "", forKey: keyAppUser + #keyPath(AppUser.personal_description))
            isDirty = true
        }
    }
    @objc var profit:String?{
        didSet{
            mDic.updateValue(profit ?? "", forKey: keyAppUser + #keyPath(AppUser.profit))
            isDirty = true
        }
    }
    @objc var resume_percent:String?{
        didSet{
            mDic.updateValue(resume_percent ?? "", forKey: keyAppUser + #keyPath(AppUser.resume_percent))
            isDirty = true
        }
    }
    @objc var headimgurl:String?{
        didSet{
            mDic.updateValue(headimgurl ?? "", forKey: keyAppUser + #keyPath(AppUser.headimgurl))
            isDirty = true
        }
    }
    @objc var phone:String?{
        didSet{
            mDic.updateValue(phone ?? "", forKey: keyAppUser + #keyPath(AppUser.phone))
            isDirty = true
        }
    }
    
    @objc var hasLogined:Bool = false{
        didSet{
            mDic.updateValue(hasLogined, forKey: keyAppUser + #keyPath(hasLogined))
            isDirty = true
        }
    }
    
    var isDirty:Bool = false
    var mDic:[String:Any] = [:]
    
    ///加载相关信息
    func loadUserWithIdentifer(identifier:String){
        if identifier.isEmpty {
            return
        }
        if uid == identifier{
            return
        }
        guard let dic = userDefaults.value(forKey:keyAppUser + identifier) as? [String:Any] else {
            return
        }
        if dic.count > 0 {
            mDic = dic
            uid = mDic[keyAppUser + #keyPath(AppUser.uid)] as? String ?? ""
            name = mDic[keyAppUser + #keyPath(AppUser.name)] as? String ?? ""
            
            sex = mDic[keyAppUser + #keyPath(AppUser.sex)] as? String ?? ""
            age = mDic[keyAppUser + #keyPath(AppUser.age)] as? String ?? ""
            education = mDic[keyAppUser + #keyPath(AppUser.education)] as? String ?? ""
            major = mDic[keyAppUser + #keyPath(AppUser.major)] as? String ?? ""
            interest_profession = mDic[keyAppUser + #keyPath(AppUser.interest_profession)] as? String ?? ""
            personal_description = mDic[keyAppUser + #keyPath(AppUser.personal_description)] as? String ?? ""
            profit = mDic[keyAppUser + #keyPath(AppUser.profit)] as? String ?? ""
            resume_percent = mDic[keyAppUser + #keyPath(AppUser.resume_percent)] as? String ?? ""
            headimgurl = mDic[keyAppUser + #keyPath(AppUser.headimgurl)] as? String ?? ""
            phone = mDic[keyAppUser + #keyPath(AppUser.phone)] as? String ?? ""
            hasLogined = mDic[keyAppUser + #keyPath(AppUser.hasLogined)] as? Bool ?? false
            
        }
    }
    
    func savePhoto(data: Data) {
        userDefaults.setValue(data, forKey: keyAppUser + (AppManager.sharedManager.user.uid ?? "") + "headImage")
    }

    func getPhoto() ->UIImage? {
        if let data = userDefaults.value(forKey: keyAppUser + (AppManager.sharedManager.user.uid ?? "") + "headImage") as? Data {
            if let image = UIImage.init(data: data) {
                return image
            }
        }
        return nil
    }
    
    ///保存信息，支持多账户登录
    func save(){
        if isDirty{
            userDefaults.setValue(mDic, forKey: keyAppUser + (AppManager.sharedManager.user.uid ?? ""))
            userDefaults.synchronize()
            isDirty = false
        }
    }
}
