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
        callback()
    }
    
    func addHeadView(){
        let sectionModel = getSectionModel()
        let noDeviceCellmodel = CellModel()
        noDeviceCellmodel.cellHeight = {table,index in
            return 1200
        }
        noDeviceCellmodel.cell = {table,index in
            let cell = SelectTypeCell.initWithXIb() as! SelectTypeCell
            cell.selectionStyle = .none
            return cell
        }
        sectionModel.cellModelsArr.append(noDeviceCellmodel)
    }
}
