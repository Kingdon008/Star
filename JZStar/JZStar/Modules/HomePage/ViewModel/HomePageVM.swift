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
    private var merchantModel:MerchantModel?
    private var currentData:[DetailMerchantModel]?
    private var currentType:Int?{
        didSet{
            if let dataArr = merchantModel?.data{
                for model in dataArr {
                    if currentType == model.id {
                        currentData = model.data
                    }
                }
                addDetailCells()
            }
        }
    }
    override init() {
        super.init()
        loadNet()
    }
    
    private func loadNet(){
        let dataStr = "{\"status\":1,     \"data\":[         {             \"id\":\"1\",             \"name\":\"推荐\",             \"data\":[                 {                     \"id\":\"4\",                     \"title\":\"美容美发\",                     \"company_name\":\"阿索贸易有限公司\",                     \"salary_describe\":\"底薪+提成\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"月结,按单\"                 },                 {                     \"id\":\"3\",                     \"title\":\"上海老佛爷百货地摊兼职招募\",                     \"company_name\":\"金店有限公司\",                     \"salary_describe\":\"8元\\/单\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"按单\"                 },                 {                     \"id\":\"2\",                     \"title\":\"在家兼职[免费，正规，简单]\",                     \"company_name\":\"德米移动科技\",                     \"salary_describe\":\"300\\/天\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"月结,推荐\"                 }]         },         {             \"id\":\"2\",             \"name\":\"全职\",             \"data\":[                 {                     \"id\":\"3\",                     \"title\":\"上海老佛爷百货地摊兼职招募\",                     \"company_name\":\"金店有限公司\",                     \"salary_describe\":\"8元\\/单\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"按单\"                 },                 {                     \"id\":\"2\",                     \"title\":\"在家兼职[免费，正规，简单]\",                     \"company_name\":\"德米移动科技\",                     \"salary_describe\":\"300\\/天\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"月结,推荐\"                 }]         },         {             \"id\":\"3\",             \"name\":\"兼职\",             \"data\":[                 {                     \"id\":\"4\",                     \"title\":\"美容美发\",                     \"company_name\":\"阿索贸易有限公司\",                     \"salary_describe\":\"底薪+提成\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"月结,按单\"                 },                 {                     \"id\":\"2\",                     \"title\":\"在家兼职[免费，正规，简单]\",                     \"company_name\":\"德米移动科技\",                     \"salary_describe\":\"300\\/天\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"月结,推荐\"                 }]         },         {             \"id\":\"4\",             \"name\":\"热门推荐\",             \"data\":[                 {                     \"id\":\"4\",                     \"title\":\"美容美发\",                     \"company_name\":\"阿索贸易有限公司\",                     \"salary_describe\":\"底薪+提成\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"月结,按单\"                 },                 {                     \"id\":\"3\",                     \"title\":\"上海老佛爷百货地摊兼职招募\",                     \"company_name\":\"金店有限公司\",                     \"salary_describe\":\"8元\\/单\",                     \"is_fulltime\":\"1\",                     \"is_parttime\":\"1\",                     \"tag_name\":\"按单\"                 }]         }] } "
        merchantModel = dataStr.kj.model(MerchantModel.self)
        currentType = merchantModel?.data?.first?.id
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
        let sectionModel = getSectionModel()
        sectionModel.cellModelsArr.removeAll()
        completeResumeView()
        addTypeView()
        addDetailCells()
        callback()
    }
    
    private func addTypeView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 60
        }
        selectTypeCellmodel.cell = {table,index in
            let cell = SelectTypeCell.initWithXIb() as! SelectTypeCell
            cell.selectionStyle = .none
            cell.setData(data: self.merchantModel as Any)
            return cell
        }
        sectionModel.cellModelsArr.append(selectTypeCellmodel)
    }
    
    private func completeResumeView(){
        let sectionModel = getSectionModel()
        let selectTypeCellmodel = CellModel()
        selectTypeCellmodel.cellHeight = {table,index in
            return 60
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
        for _ in 0...25{
            let selectDetailCellmodel = CellModel()
            selectDetailCellmodel.cellHeight = {table,index in
                return 95
            }
            selectDetailCellmodel.cell = {table,index in
                let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
                cell.selectionStyle = .none
                return cell
            }
            selectDetailCellmodel.cellClassName = NSStringFromClass(SelectDetailViewCell.self)
            sectionModel.cellModelsArr.append(selectDetailCellmodel)
        }
//        currentData?.forEach({ (model) in
//            let selectDetailCellmodel = CellModel()
//            selectDetailCellmodel.cellHeight = {table,index in
//                return 95
//            }
//            selectDetailCellmodel.cell = {table,index in
//                let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
//                cell.selectionStyle = .none
//                cell.setData(data: model)
//                return cell
//            }
//            sectionModel.cellModelsArr.append(selectDetailCellmodel)
//        })
        
    }
    
    func loadDetailCells(){
        let sectionModel = getSectionModel()
//        for cellModel in sectionModel.cellModelsArr {
//            if let cellClassName = cellModel.cellClassName{
//                if cellClassName == NSStringFromClass(SelectDetailViewCell.self) {
//                    if let index = sectionModel.cellModelsArr.firstIndex(of: cellModel){
//                        sectionModel.cellModelsArr.remove(at: index)
//                    }
//                }
//            }
//        }
        
        
        
//        if let arr = currentData {
//            for model in arr {
//                let selectDetailCellmodel = CellModel()
//                selectDetailCellmodel.cellHeight = {table,index in
//                    return 95
//                }
//                selectDetailCellmodel.cell = {table,index in
//                    let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
//                    cell.selectionStyle = .none
//                    cell.setData(data: model)
//                    return cell
//                }
//                sectionModel.cellModelsArr.append(selectDetailCellmodel)
//            }
//        }
        var addArr = [DetailMerchantModel]()
        merchantModel?.data?.forEach({ (merchantClassifyModel) in
            if currentType == merchantClassifyModel.id, let needAddArr = merchantClassifyModel.data{
                addArr += needAddArr
            }
        })
        
        addArr.forEach({ (model) in
            let selectDetailCellmodel = CellModel()
            selectDetailCellmodel.cellHeight = {table,index in
                return 95
            }
            selectDetailCellmodel.cell = {table,index in
                let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
                cell.selectionStyle = .none
                cell.setData(data: model)
                return cell
            }
            sectionModel.cellModelsArr.append(selectDetailCellmodel)
        })
        
        tableViewDataModel.tableView?.reloadData()
    }
}
