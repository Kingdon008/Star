//
//  HomePageVM.swift
//  JZStar
//
//  Created by don on 2020/6/2.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

@objc protocol HomePageVMDelegate {
    func pushViewController(vc: UIViewController)
}


class HomePageVM: NSObject {
    weak var vmDelegate: HomePageVMDelegate?
    var tableViewDataModel = TableViewDataModel()
    var reloadTypes:(([String])->Void)?
    private var allDataArr = [MerchantModel]()
    private var currentData = [DetailMerchantModel]()
    private var currentID:Int?
    var currentName:String?{
        didSet{
            for model in allDataArr {
                if currentName == model.name {
                    currentData = model.data
                    currentID = model.id
                }
            }
            addDetailCells()
        }
    }
    
    override init() {
        super.init()
    }
    
    private func loadNet(){
        Network.request(.homeContent, success: { (json) in
            if let data = json["data"].arrayObject?.kj.modelArray(MerchantModel.self){
                self.allDataArr = data
                self.currentName = self.allDataArr.first?.name
                var titles = [String]()
                for merchantClassifyModel in self.allDataArr {
                    if let name =  merchantClassifyModel.name{
                        titles.append(name)
                    }
                }
                self.reloadTypes?(titles)
                let sectionModel = self.getSectionModel()
                sectionModel.cellModelsArr.removeAll()
                self.completeResumeView()
                self.addTypeView()
                self.addDetailCells()
            }
        }) { (error, message) in
            
        }
        
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
    
    func setData(callback:@escaping ()->Void){
        loadNet()
        callback()
    }
    
    private func addTypeView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 50
        }
        selectTypeCellmodel.cell = {table,index in
            let cell = SpaceCell.initWithXIb() as! SpaceCell
            cell.selectionStyle = .none
            return cell
        }
        sectionModel.cellModelsArr.append(selectTypeCellmodel)
    }
    
    private func completeResumeView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 104
        }
        selectTypeCellmodel.cell = {table,index in
            let cell = CompleteResumeCell.initWithXIb() as! CompleteResumeCell
            cell.selectionStyle = .none
            return cell
        }
        selectTypeCellmodel.selectRow = { tableview, indexPath in
            let vc = MyResumeVC()
            self.vmDelegate?.pushViewController(vc: vc)
        }
        sectionModel.cellModelsArr.append(selectTypeCellmodel)
    }
    
    private func addDetailCells(){
        let sectionModel = getSectionModel()
        for cellModel in sectionModel.cellModelsArr {
            if let cellClassName = cellModel.cellClassName{
                if cellClassName == NSStringFromClass(SelectDetailViewCell.self) {
                    if let index = sectionModel.cellModelsArr.firstIndex(of: cellModel){
                        sectionModel.cellModelsArr.remove(at: index)
                    }
                }
            }
        }
        var addArr = [DetailMerchantModel]()
        allDataArr.forEach({ (merchantClassifyModel) in
            if currentName == merchantClassifyModel.name{
                addArr += merchantClassifyModel.data
            }
        })
        addArr.forEach({ (model) in
            let selectDetailCellmodel = CellModel()
            selectDetailCellmodel.cellHeight = {table,index in
                return 124
            }
            selectDetailCellmodel.cell = {table,index in
                let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
                cell.selectionStyle = .none
                cell.setData(data: model)
                return cell
            }
            selectDetailCellmodel.selectRow = { tableview, indexPath in
                let vc = DetailPositionVC()
                vc.positionId = model.id
                self.vmDelegate?.pushViewController(vc: vc)
            }
            selectDetailCellmodel.cellClassName = NSStringFromClass(SelectDetailViewCell.self)
            sectionModel.cellModelsArr.append(selectDetailCellmodel)
        })
        tableViewDataModel.tableView?.reloadData()
    }
    
    
    func loadMoreData(){
        guard let id = currentID else {
            return
        }
        Network.request(.homePosition(id: id, limit: currentData.count), success: { (json) in
            if let addArr = json["data"].arrayObject?.kj.modelArray(DetailMerchantModel.self){
                self.currentData += addArr
                self.addMoreDetailCells(addArr: addArr)
            }
        }) { (error, message) in
            
        }
    }
    
    
    private func addMoreDetailCells(addArr:[DetailMerchantModel]){
        for model in allDataArr{
            if model.id == self.currentID{
                model.data += addArr
            } 
        }
        let sectionModel = getSectionModel()
        addArr.forEach({ (model) in
            let selectDetailCellmodel = CellModel()
            selectDetailCellmodel.cellHeight = {table,index in
                return 124
            }
            selectDetailCellmodel.cell = {table,index in
                let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
                cell.selectionStyle = .none
                cell.setData(data: model)
                return cell
            }
            selectDetailCellmodel.selectRow = { tableview, indexPath in
                let vc = DetailPositionVC()
                vc.positionId = model.id
                self.vmDelegate?.pushViewController(vc: vc)
            }
            selectDetailCellmodel.cellClassName = NSStringFromClass(SelectDetailViewCell.self)
            sectionModel.cellModelsArr.append(selectDetailCellmodel)
        })
        tableViewDataModel.tableView?.reloadData()
    }
}
