//
//  PersonVM.swift
//  JZStar
//
//  Created by don on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class PersonVM: NSObject {
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
        addHeadView()
        addDetailCells()
        callback()
    }
    
    private func addHeadView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 230
        }
        cellModel.cell = {table,index in
            let cell = PersonalHeadCell.initWithXIb() as! PersonalHeadCell
            cell.selectionStyle = .none
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
        
    private func addDetailCells(){
        let titles = ["我的职位","我的福利","客服中心","意见投诉","关于我们"]
        for title in titles{
            let sectionModel = getSectionModel()
            let cellModel = CellModel()
            cellModel.cellHeight = {table,index in
                return 88
            }
            cellModel.cell = {table,index in
                let cell = PersonalDetailCell.initWithXIb() as! PersonalDetailCell
                cell.nameLabel.text = title
                cell.selectionStyle = .none
                return cell
            }
            sectionModel.cellModelsArr.append(cellModel)
        }
        
    }
}
