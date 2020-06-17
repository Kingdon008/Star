//
//  DetailPositionVM.swift
//  JZStar
//
//  Created by herodon on 2020/6/16.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailPositionVM: NSObject {
    var tableViewDataModel = TableViewDataModel()
    var positionId:Int?
    private var positionModel:DetailPositionModel?
    override init() {
        super.init()
    }
    
    func setData(callback:@escaping ()->Void){
        if let currentPositionId = positionId{
            Network.request(.positionContent(id: currentPositionId), success: { (json) in
                self.positionModel =  JSON(json["data"].arrayObject?.first ?? "").description.kj.model(DetailPositionModel.self)
                self.addHeadView()
                self.addContentView()
                callback()

            }) { (error, message) in
                
            }
        }
    }
    
    private func addHeadView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 126
        }
        selectTypeCellmodel.cell = {table,index in
            let cell = DetailJobHeadCell.initWithXIb() as! DetailJobHeadCell
            cell.selectionStyle = .none
            cell.setData(data: self.positionModel as Any)
            return cell
        }
        sectionModel.cellModelsArr.append(selectTypeCellmodel)
    }
    
    private func addContentView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 389
        }
        selectTypeCellmodel.cell = {table,index in
            let cell = DetailJobContentCell.initWithXIb() as! DetailJobContentCell
            cell.setData(data: self.positionModel as Any)
            cell.selectionStyle = .none
            return cell
        }
        sectionModel.cellModelsArr.append(selectTypeCellmodel)
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
}
