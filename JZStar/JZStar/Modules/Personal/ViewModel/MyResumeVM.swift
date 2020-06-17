//
//  MyResumeVM.swift
//  JZStar
//
//  Created by herodon on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumeVM: NSObject {
    weak var vmDelegate: PersonVMDelegate?
    var tableViewDataModel = TableViewDataModel()
    var setdata:(()->Void)?
    
    override init() {
        super.init()
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
            cell.selectionStyle = .none
            cell.setData(type: "姓名", text: nil)
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
            cell.setData(type: "性别", text: nil)
            return cell
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
            cell.selectionStyle = .none
            cell.setData(type: "年龄", text: nil)
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
            cell.setData(type: "学历", text: nil)
            return cell
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
            cell.setData(type: "专业", text: nil)
            return cell
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
            let cell = MyResumePickUpCell.initWithXIb() as! MyResumePickUpCell
            cell.selectionStyle = .none
            cell.setData(type: "意向专业", text: nil)
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func addPersonalIntroduceView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 120
        }
        cellModel.cell = {table,index in
            let cell = MyResumeMoreInputCell.initWithXIb() as! MyResumeMoreInputCell
            cell.selectionStyle = .none
            cell.setData(type: "个人介绍", text: nil)
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
}
