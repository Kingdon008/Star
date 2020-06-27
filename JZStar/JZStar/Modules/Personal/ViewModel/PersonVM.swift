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
    var userModel:UserModel?
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
            cell.setData(data: self.userModel as Any)
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
            cell.perLabel.text = "\(self.userModel?.resume_percent ?? "")%"
            return cell
        }
        selectTypeCellmodel.selectRow = { _ ,_ in
            let vc = MyResumeVC()
            self.vmDelegate?.pushViewController(vc: vc)
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
        let types:[PersonalListType] = [.myJob,.service,.comments,.aboutUs,.loginOut]
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
                switch type {
                case .myJob:
                    let vc = MyJobVC()
                    self.vmDelegate?.pushViewController(vc: vc)
                case .service:
                    let vc = MyServiceVC()
                    self.vmDelegate?.pushViewController(vc: vc)
                case .comments:
                    let vc = OpinionAndComplaintVC()
                    self.vmDelegate?.pushViewController(vc: vc)
                case .aboutUs:
                    let vc = AboutUsVC()
                    self.vmDelegate?.pushViewController(vc: vc)
                case .loginOut:
                    AppManager.sharedManager.nextStep()
                }
                
            }
            sectionModel.cellModelsArr.append(cellModel)
        }
        
    }
}
