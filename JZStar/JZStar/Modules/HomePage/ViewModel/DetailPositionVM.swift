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
            return 156
        }
        selectTypeCellmodel.cell = {table,index in
            let cell = DetailJobContentCell.initWithXIb() as! DetailJobContentCell
            cell.setData(data: self.positionModel as Any)
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 36, bottom: 0, right: 36)
            return cell
        }
        sectionModel.cellModelsArr.append(selectTypeCellmodel)
        
        if let workContent = self.positionModel?.content,!workContent.isEmpty{
            let workContentCellmodel = CellModel()
            workContentCellmodel.cellHeight = {table,index in
                return self.getContentFrameHeight(text: workContent)
            }
            workContentCellmodel.cell = {table,index in
                let cell = DetailTitleContentCell.initWithXIb() as! DetailTitleContentCell
                cell.setData(title: "工作内容", text: workContent)
                cell.selectionStyle = .none
                cell.separatorInset = UIEdgeInsets.init(top: 0, left: 36, bottom: 0, right: 36)
                return cell
            }
            sectionModel.cellModelsArr.append(workContentCellmodel)
        }
        
        if let workPlace = self.positionModel?.workplace{
            let workContentCellmodel = CellModel()
            workContentCellmodel.cellHeight = {table,index in
                return self.getContentFrameHeight(text: workPlace)
            }
            workContentCellmodel.cell = {table,index in
                let cell = DetailTitleContentCell.initWithXIb() as! DetailTitleContentCell
                cell.setData(title: "工作地址", text: workPlace)
                cell.selectionStyle = .none
                return cell
            }
            sectionModel.cellModelsArr.append(workContentCellmodel)
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
    
    func getContentFrameHeight(text:String)->CGFloat{
//        let rect = String.ss.getTextRectSize(text: text,font: UIFont.systemFont(ofSize: 14),size: CGSize.init(width: kScreenWidth - 36 - 44, height: CGFloat(MAXFLOAT)))
        let attrStr = try! NSMutableAttributedString(
            data: (text.data(using: .unicode, allowLossyConversion: true)!),
            options:[.documentType: NSAttributedString.DocumentType.html,
                     .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        let contentHegiht = attrStr.boundingRect(with: CGSize(width:  kScreenWidth - 36 - 44, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).height
        return contentHegiht + 65 + 24
    }
}
