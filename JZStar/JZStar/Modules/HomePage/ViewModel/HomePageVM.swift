//
//  HomePageVM.swift
//  JZStar
//
//  Created by don on 2020/6/2.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class HomePageVM: NSObject {
    var tableViewDataModel = TableViewDataModel()
    var reloadTypes:(([String])->Void)?
    private var merchantModel:MerchantModel?
    private var currentData:[DetailMerchantModel]?
    var currentName:String?{
        didSet{
            if let dataArr = merchantModel?.data{
                for model in dataArr {
                    if currentName == model.name {
                        currentData = model.data
                    }
                }
                addDetailCells()
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    private func loadNet(){
        Network.request(.homeContent, success: { (json) in
            self.merchantModel = json.debugDescription.kj.model(MerchantModel.self)
            self.currentName = self.merchantModel?.data?.first?.name
            var titles = [String]()
            if let arr = self.merchantModel?.data{
                for merchantClassifyModel in arr {
                    if let name =  merchantClassifyModel.name{
                        titles.append(name)
                    }
                }
            }
            self.reloadTypes?(titles)
            let sectionModel = self.getSectionModel()
            sectionModel.cellModelsArr.removeAll()
            self.completeResumeView()
            self.addTypeView()
            self.addDetailCells()
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
        merchantModel?.data?.forEach({ (merchantClassifyModel) in
            if currentName == merchantClassifyModel.name, let needAddArr = merchantClassifyModel.data{
                addArr += needAddArr
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
            selectDetailCellmodel.cellClassName = NSStringFromClass(SelectDetailViewCell.self)
            sectionModel.cellModelsArr.append(selectDetailCellmodel)
        })
        tableViewDataModel.tableView?.reloadData()
    }
}
