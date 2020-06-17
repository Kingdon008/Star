//
//  PersonVM.swift
//  JZStar
//
//  Created by don on 2020/6/4.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

@objc protocol PersonVMDelegate {
    func pushViewController(vc: UIViewController)
}

class PersonVM: NSObject {
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
        addHeadView()
        improveResumeView()
        addDetailCells()
        callback()
    }
    
    private func addHeadView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return 154
        }
        cellModel.cell = {table,index in
            let cell = PersonalHeadCell.initWithXIb() as! PersonalHeadCell
            cell.selectionStyle = .none
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    private func improveResumeView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 74
        }
        selectTypeCellmodel.cell = {table,index in
            let cell = ImproveResumeCell.initWithXIb() as! ImproveResumeCell
            cell.selectionStyle = .none
            return cell
        }
        sectionModel.cellModelsArr.append(selectTypeCellmodel)
        
        let spaceCellmodel = CellModel()
        spaceCellmodel.cellHeight = {table,index in
            return 20
        }
        spaceCellmodel.cell = {table,index in
            let cell = SpaceCell.initWithXIb() as! SpaceCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.init(hexString: "#F3F3F3")
            return cell
        }
        sectionModel.cellModelsArr.append(spaceCellmodel)
    }
        
    private func addDetailCells(){
        let types:[PersonalListType] = [.myJob,.myWelfare,.service,.comments,.aboutUs,.loginOut]
        for type in types{
            let sectionModel = getSectionModel()
            let cellModel = CellModel()
            cellModel.cellHeight = {table,index in
                return 62
            }
            cellModel.cell = {table,index in
                let cell = PersonalDetailCell.initWithXIb() as! PersonalDetailCell
                cell.setType(type: type)
                cell.selectionStyle = .none
                return cell
            }
            cellModel.selectRow = { tableview, indexPath in
                let vc = MyJobVC()
                self.vmDelegate?.pushViewController(vc: vc)
            }
            sectionModel.cellModelsArr.append(cellModel)
        }
        
    }
}
