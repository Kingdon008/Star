//
//  ServiceVM.swift
//  JZStar
//
//  Created by herodon on 2020/6/19.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class ServiceVM: NSObject {
    var tableViewDataModel = TableViewDataModel()
    var setdata:(()->Void)?
    var dataArr = [AboutUsModel]()
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
    
    private func addHeadView(){
        let sectionModel = getSectionModel()
        let cellModel = CellModel()
        cellModel.cellHeight = {table,index in
            return self.getHeadHeight()
        }
        cellModel.cell = {table,index in
            let cell = ServiceHeadCell.initWithXIb() as! ServiceHeadCell
            cell.selectionStyle = .none
            cell.setData(data: self.dataArr)
            cell.titleClickBlock = { model in
                self.adddialogueView(dia:model)
            }
            return cell
        }
        sectionModel.cellModelsArr.append(cellModel)
    }
    
    
    
    private func getHeadHeight() -> CGFloat{
        let tempheight = 25 + 40 + 4 + dataArr.count * (16 + 20) + 23
        return CGFloat(tempheight < 162 ? 162 : tempheight)
    }
    
    func adddialogueView(dia:AboutUsModel){
        let diaFont = UIFont.systemFont(ofSize: 14)

        let sectionModel = getSectionModel()
        //problem
        let problemheight = String.ss.getTextRectSize(text: dia.problem ?? "",font: diaFont,size: CGSize.init(width: kScreenWidth - 90 - 60 - 40, height: kScreenHeight)).height
        let problemcellModel = CellModel()
        problemcellModel.cellHeight = {table,index in
            return problemheight + 16 + 16
        }
        problemcellModel.cell = {table,index in
            let cell = RightDialogueCell.initWithXIb() as! RightDialogueCell
            cell.selectionStyle = .none
            cell.setDialogueText(dia.problem ?? "")
            return cell
        }
        sectionModel.cellModelsArr.append(problemcellModel)
        
        //answer
        let answerheight = String.ss.getTextRectSize(text: dia.answer ?? "",font: diaFont,size: CGSize.init(width: kScreenWidth - 90 - 60 - 40, height: kScreenHeight)).height
        let askcellModel = CellModel()
        askcellModel.cellHeight = {table,index in
            return answerheight + 16 + 16
        }
        askcellModel.cell = {table,index in
            let cell = LeftDialogueCell.initWithXIb() as! LeftDialogueCell
            cell.selectionStyle = .none
            cell.setDialogueText(dia.answer ?? "")
            return cell
        }
        sectionModel.cellModelsArr.append(askcellModel)
        
        tableViewDataModel.tableView?.reloadData()
        let lastIndex = IndexPath.init(row: sectionModel.cellModelsArr.count - 1, section: 0)
        tableViewDataModel.tableView?.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
}
