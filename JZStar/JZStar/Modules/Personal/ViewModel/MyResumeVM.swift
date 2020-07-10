//
//  MyResumeVM.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

@objc protocol MyResumeVMDelegate {
    func modificationInfo(param:[String: Any] )
    func endEditState()
    func pushViewController(vc: UIViewController)
}

enum ResumePickViewSeleType {
    case pickViewSex
    case education
    case major
    case intentionMajor
    case interestOnline
    case introduce
}

class MyResumeVM: NSObject {
    weak var vmDelegate: MyResumeVMDelegate?
    var tableViewDataModel = TableViewDataModel()
    var setdata:(()->Void)?
    var myResumeModel:MyResumeModel?
    private var pickerView:BHJPickerView!
    var myResumeName:String?{
        get{
            self.myNameInputCell?.textfield.text
        }
    }
    var myResumeAge:String?{
        get{
            self.myAgeInputCell?.textfield.text
        }
    }
    var myResumeIntroduction:String?{
        get{
            self.myIntroduceInputCell?.textView.text
        }
    }
    let dataOpreation:JFCSDataOpreation!
    let config:JFCSConfiguration!
    private var myPickViewSeleType:ResumePickViewSeleType?
    private var myNameInputCell:MyResumeInputCell?
    private var myAgeInputCell:MyResumeInputCell?
    private var myIntroduceInputCell:MyResumeMoreInputCell?
    
    override init() {
        self.config = JFCSConfiguration()
        self.dataOpreation = JFCSDataOpreation(configuration: config)
        super.init()
        self.pickerView = BHJPickerView.init(self)
    }
    
    private func getSectionModel() -> TableViewSectionModel{
        if let sectionModel = tableViewDataModel.tableViewDataArr.first{
            return sectionModel
        }else{
            let sectionModel = TableViewSectionModel()
            tableViewDataModel.tableViewDataArr.append(sectionModel)
            return sectionModel
        }
    }
    
    func setData(callback:()->Void){
        let sectionModel = getSectionModel()
        sectionModel.cellModelsArr.removeAll()
        addNameView()
        addSexView()
        addAgeView()
        addSchoolView()
        addMajorView()
        addIntentionMajorView()
        addInterestOnlineView()
        addPersonalIntroduceView()
        callback()
    }
    
    private func addNameView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 87
        }
        cellModel.cell = {table,index in
            let cell = MyResumeInputCell.initWithXIb() as! MyResumeInputCell
            self.myNameInputCell = cell
            cell.selectionStyle = .none
            let name = self.myResumeModel?.resume.name
            cell.setData(type: "姓名", text: name)
            cell.textClickBlock = { text in
                self.myResumeModel?.resume.name = text
                guard let model = self.myResumeModel?.resume else {
                    return
                }
                self.vmDelegate?.modificationInfo(param: model.kj.JSONObject())
            }
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addSexView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 87
        }
        cellModel.cell = {table,index in
            let cell = MyResumePickUpCell.initWithXIb() as! MyResumePickUpCell
            cell.selectionStyle = .none
            let sex = self.myResumeModel?.resume.sex
            var sexStr:String?
            if sex == 1 {
                sexStr = "男"
            }else if sex == 2{
                sexStr = "女"
            }
            cell.setData(type: "性别", text: sexStr)
            return cell
        }
        cellModel.selectRow = { tableview,indexPath in
            self.vmDelegate?.endEditState()
            self.myPickViewSeleType = .pickViewSex
            self.pickerView.setData(arr: ["男","女"])
            var currentIndex = 0
            if self.myResumeModel?.resume.sex == 2{
                currentIndex = 1
            }
            self.pickerView.pickerViewShow(currentIndex)
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addAgeView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 87
        }
        cellModel.cell = {table,index in
            let cell = MyResumeInputCell.initWithXIb() as! MyResumeInputCell
            self.myAgeInputCell = cell
            cell.selectionStyle = .none
            let age = self.myResumeModel?.resume.age
            cell.textfield.keyboardType = .numberPad
            cell.setData(type: "年龄", text: age)
            cell.textClickBlock = { text in
                self.myResumeModel?.resume.age = text
                guard let model = self.myResumeModel?.resume else {
                    return
                }
                self.vmDelegate?.modificationInfo(param: model.kj.JSONObject())
            }
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addSchoolView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 87
        }
        cellModel.cell = {table,index in
            let cell = MyResumePickUpCell.initWithXIb() as! MyResumePickUpCell
            cell.selectionStyle = .none
            let education = self.myResumeModel?.resume.education
            cell.setData(type: "学历", text: education)
            return cell
        }
        cellModel.selectRow = { tableview,indexPath in
            self.vmDelegate?.endEditState()
            if let arr = self.myResumeModel?.education.map({ model -> String in
                (model.name ?? "")
            }){
                self.myPickViewSeleType = .education
                self.pickerView.setData(arr: arr)
                let currentIndex = self.myResumeModel?.education.firstIndex(where: {$0.name == self.myResumeModel?.resume.education})
                self.pickerView.pickerViewShow(currentIndex ?? 0)
            }
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addMajorView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 87
        }
        cellModel.cell = {table,index in
            let cell = MyResumePickUpCell.initWithXIb() as! MyResumePickUpCell
            cell.selectionStyle = .none
            let education = self.myResumeModel?.resume.major
            cell.setData(type: "专业", text: education)
            return cell
        }
        cellModel.selectRow = { tableview,indexPath in
            self.vmDelegate?.endEditState()
            if let arr = self.myResumeModel?.interest_profession.map({ model -> String in
                (model.name ?? "")
            }){
                self.myPickViewSeleType = .major
                self.pickerView.setData(arr: arr)
                let currentIndex = self.myResumeModel?.interest_profession.firstIndex(where: {$0.name == self.myResumeModel?.resume.major})
                self.pickerView.pickerViewShow(currentIndex ?? 0)
            }
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addIntentionMajorView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 87
        }
        cellModel.cell = {table,index in
            self.vmDelegate?.endEditState()
            let cell = MyResumePickUpCell.initWithXIb() as! MyResumePickUpCell
            cell.selectionStyle = .none
            let interest_profession = self.myResumeModel?.resume.interest_profession
            cell.setData(type: "意向专业", text: interest_profession)
            return cell
        }
        cellModel.selectRow = { tableview,indexPath in
            if let arr = self.myResumeModel?.interest_profession.map({ model -> String in
                (model.name ?? "")
            }){
                self.myPickViewSeleType = .intentionMajor
                self.pickerView.setData(arr: arr)
                let currentIndex = self.myResumeModel?.interest_profession.firstIndex(where: {$0.name == self.myResumeModel?.resume.interest_profession})
                self.pickerView.pickerViewShow(currentIndex ?? 0)
            }
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addInterestOnlineView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 87
        }
        cellModel.cell = {table,index in
            self.vmDelegate?.endEditState()
            let cell = MyResumePickUpCell.initWithXIb() as! MyResumePickUpCell
            cell.selectionStyle = .none
            let interest_workplace = (self.myResumeModel?.resume.interest_online ?? false) ? "" : self.myResumeModel?.resume.interest_work_place
            cell.setData(type: "意向工作地点", text: interest_workplace)
            return cell
        }
        cellModel.selectRow = { tableview,indexPath in
            let arr = ["线上/在家","线下/外派"]
            self.myPickViewSeleType = .interestOnline
            self.pickerView.setData(arr: arr)
            let currentIndex = (self.myResumeModel?.resume.interest_online ?? false) ? 0 : 1
            self.pickerView.pickerViewShow(currentIndex)
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addPersonalIntroduceView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 220
        }
        cellModel.cell = {table,index in
            let cell = MyResumeMoreInputCell.initWithXIb() as! MyResumeMoreInputCell
            self.myIntroduceInputCell = cell
            cell.selectionStyle = .none
            let interest_profession = self.myResumeModel?.resume.personal_description
            cell.setData(type: "个人介绍", text: interest_profession)
            cell.textClickBlock = { text in
                self.myResumeModel?.resume.personal_description = text
                guard let model = self.myResumeModel?.resume else {
                    return
                }
                self.vmDelegate?.modificationInfo(param: model.kj.JSONObject())
            }
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
}

extension MyResumeVM:PickerDelegate{
    func selectedGender(_ pickerView: BHJPickerView, _ seleStr: String) {
        if self.myPickViewSeleType == .pickViewSex {
            if seleStr == "男" {
                self.myResumeModel?.resume.sex = 1
            }else if seleStr == "女" {
                self.myResumeModel?.resume.sex = 2
            }
        }else if self.myPickViewSeleType == .education {
            self.myResumeModel?.resume.education = seleStr
            self.myResumeModel?.education.forEach({
                if $0.name == seleStr{
                    self.myResumeModel?.resume.education_id = $0.id
                }
            })
        }else if self.myPickViewSeleType == ResumePickViewSeleType.major {
            self.myResumeModel?.resume.major = seleStr
        }else if self.myPickViewSeleType == ResumePickViewSeleType.intentionMajor {
            self.myResumeModel?.resume.interest_profession = seleStr
            self.myResumeModel?.interest_profession.forEach({
                if $0.name == seleStr{
                    self.myResumeModel?.resume.interest_profession_id = $0.id
                }
            })
        }else if self.myPickViewSeleType == ResumePickViewSeleType.interestOnline {
            if seleStr == "线上/在家" {
                self.myResumeModel?.resume.interest_online = true
                self.myResumeModel?.resume.interest_work_place = ""
            }else{
                self.myResumeModel?.resume.interest_online = false
                let vc = JFCSTableViewController(configuration: self.config, delegate: self)
                self.vmDelegate?.pushViewController(vc: vc)
            }
            
        }
        guard let model = self.myResumeModel?.resume else {
            return
        }
        vmDelegate?.modificationInfo(param: model.kj.JSONObject())
        tableViewDataModel.tableView?.reloadData()
        
    }
    
    
    
}

extension MyResumeVM:JFCSTableViewControllerDelegate{
    func viewController(_ viewController:JFCSTableViewController,didSelectCity model:JFCSBaseInfoModel){
        var interest_work_place = ""
        
        if let areaModel = model as? JFCSArea{
            let cityname = dataOpreation.getCityWithCode(areaModel.cityCode).name
            let provincname = dataOpreation.getProvinceWithCode(areaModel.provinceCode).name
            interest_work_place += (provincname + "/" + cityname + "/" + areaModel.name )
            self.myResumeModel?.resume.interest_work_place = interest_work_place
            guard let resumeModel = self.myResumeModel?.resume else {
                return
            }
            vmDelegate?.modificationInfo(param: resumeModel.kj.JSONObject())
            tableViewDataModel.tableView?.reloadData()
            return
        }
        
        if let cityModel = model as? JFCSCity{
            let provincname = dataOpreation.getProvinceWithCode(cityModel.provinceCode).name
            interest_work_place += (provincname + "/" + cityModel.name)
            self.myResumeModel?.resume.interest_work_place = interest_work_place
            guard let resumeModel = self.myResumeModel?.resume else {
                return
            }
            vmDelegate?.modificationInfo(param: resumeModel.kj.JSONObject())
            tableViewDataModel.tableView?.reloadData()
            return
        }
        
        if let provinceModel = model as? JFCSProvince{
            let provincname = provinceModel.name
            interest_work_place += provincname
            self.myResumeModel?.resume.interest_work_place = interest_work_place
            guard let resumeModel = self.myResumeModel?.resume else {
                return
            }
            vmDelegate?.modificationInfo(param: resumeModel.kj.JSONObject())
            tableViewDataModel.tableView?.reloadData()
            return
        }
//        interest_work_place += (provincname + cityname + model.name)
        
    }
    
}
