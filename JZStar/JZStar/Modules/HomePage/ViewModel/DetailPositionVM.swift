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
    var positionModel:DetailPositionModel?
    override init() {
        super.init()
    }
    
    func setData(callback:@escaping ()->Void){
        addHeadView()
        addContentView()
        callback()
    }
    
    private func addHeadView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 150
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
            return self.getContentFrameHeight(text: self.positionModel?.content ?? "")
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
    
    func getContentFrameHeight(text:String)->CGFloat{
        let rect = String.ss.getTextRectSize(text: text,font: UIFont.systemFont(ofSize: 14),size: CGSize.init(width: kScreenWidth - 36 - 44, height: CGFloat(MAXFLOAT)))
        return rect.height + 245
    }
}
