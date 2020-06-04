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
        let dataStr = "{\"status\":1,\"data\":[{\"type\":\"is_recommend\",\"name\":\"\\u63a8\\u8350\",\"id\":1,\"data\":[{\"id\":\"3\",\"title\":\"\\u4e0a\\u6d77\\u8001\\u4f5b\\u7237\\u767e\\u8d27\\u5730\\u644a\\u517c\\u804c\\u62db\\u52df\",\"company_name\":\"\\u91d1\\u5e97\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"8\\u5143\\/\\u5355\"},{\"id\":\"2\",\"title\":\"\\u5728\\u5bb6\\u517c\\u804c[\\u514d\\u8d39\\uff0c\\u6b63\\u89c4\\uff0c\\u7b80\\u5355]\",\"company_name\":\"\\u5fb7\\u7c73\\u79fb\\u52a8\\u79d1\\u6280\",\"salary_describe\":\"300\\/\\u5929\"}]},{\"type\":\"is_fulltime\",\"name\":\"\\u5168\\u804c\",\"id\":1,\"data\":[{\"id\":\"5\",\"title\":\"\\u5feb\\u9012\\u914d\\u9001\",\"company_name\":\"\\u554a\\u554a\\u7269\\u6d41\\u516c\\u53f8\",\"salary_describe\":\"200-500\\/\\u5929\"},{\"id\":\"4\",\"title\":\"\\u7f8e\\u5bb9\\u7f8e\\u53d1\",\"company_name\":\"\\u963f\\u7d22\\u8d38\\u6613\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"\\u5e95\\u85aa+\\u63d0\\u6210\"},{\"id\":\"3\",\"title\":\"\\u4e0a\\u6d77\\u8001\\u4f5b\\u7237\\u767e\\u8d27\\u5730\\u644a\\u517c\\u804c\\u62db\\u52df\",\"company_name\":\"\\u91d1\\u5e97\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"8\\u5143\\/\\u5355\"},{\"id\":\"2\",\"title\":\"\\u5728\\u5bb6\\u517c\\u804c[\\u514d\\u8d39\\uff0c\\u6b63\\u89c4\\uff0c\\u7b80\\u5355]\",\"company_name\":\"\\u5fb7\\u7c73\\u79fb\\u52a8\\u79d1\\u6280\",\"salary_describe\":\"300\\/\\u5929\"}]},{\"type\":\"is_parttime\",\"name\":\"\\u517c\\u804c\",\"id\":1,\"data\":[{\"id\":\"6\",\"title\":\"\\u89c6\\u9891\\u4e3b\\u64ad\",\"company_name\":\"\\u56db\\u56db\\u6295\\u8d44\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"150-300\\/\\u5929+\\u989d\\u5916\"},{\"id\":\"5\",\"title\":\"\\u5feb\\u9012\\u914d\\u9001\",\"company_name\":\"\\u554a\\u554a\\u7269\\u6d41\\u516c\\u53f8\",\"salary_describe\":\"200-500\\/\\u5929\"},{\"id\":\"4\",\"title\":\"\\u7f8e\\u5bb9\\u7f8e\\u53d1\",\"company_name\":\"\\u963f\\u7d22\\u8d38\\u6613\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"\\u5e95\\u85aa+\\u63d0\\u6210\"},{\"id\":\"3\",\"title\":\"\\u4e0a\\u6d77\\u8001\\u4f5b\\u7237\\u767e\\u8d27\\u5730\\u644a\\u517c\\u804c\\u62db\\u52df\",\"company_name\":\"\\u91d1\\u5e97\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"8\\u5143\\/\\u5355\"},{\"id\":\"2\",\"title\":\"\\u5728\\u5bb6\\u517c\\u804c[\\u514d\\u8d39\\uff0c\\u6b63\\u89c4\\uff0c\\u7b80\\u5355]\",\"company_name\":\"\\u5fb7\\u7c73\\u79fb\\u52a8\\u79d1\\u6280\",\"salary_describe\":\"300\\/\\u5929\"}]},{\"type\":\"is_tag_type\",\"name\":\"\\u730e\\u5934\\u63a8\\u8350\",\"id\":\"3\",\"data\":[{\"id\":\"2\",\"title\":\"\\u5728\\u5bb6\\u517c\\u804c[\\u514d\\u8d39\\uff0c\\u6b63\\u89c4\\uff0c\\u7b80\\u5355]\",\"company_name\":\"\\u5fb7\\u7c73\\u79fb\\u52a8\\u79d1\\u6280\",\"salary_describe\":\"300\\/\\u5929\"}]},{\"type\":\"is_tag_type\",\"name\":\"\\u4f18\\u9009\\u804c\\u4f4d\",\"id\":\"2\",\"data\":[{\"id\":\"3\",\"title\":\"\\u4e0a\\u6d77\\u8001\\u4f5b\\u7237\\u767e\\u8d27\\u5730\\u644a\\u517c\\u804c\\u62db\\u52df\",\"company_name\":\"\\u91d1\\u5e97\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"8\\u5143\\/\\u5355\"}]},{\"type\":\"is_tag_type\",\"name\":\"\\u70ed\\u95e8\\u804c\\u4f4d\",\"id\":\"1\",\"data\":[{\"id\":\"4\",\"title\":\"\\u7f8e\\u5bb9\\u7f8e\\u53d1\",\"company_name\":\"\\u963f\\u7d22\\u8d38\\u6613\\u6709\\u9650\\u516c\\u53f8\",\"salary_describe\":\"\\u5e95\\u85aa+\\u63d0\\u6210\"}]}]}"
        merchantModel = dataStr.kj.model(MerchantModel.self)
        
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
                return 88
            }
            selectDetailCellmodel.cell = {table,index in
                let cell = SelectDetailViewCell.initWithXIb() as! SelectDetailViewCell
                cell.selectionStyle = .none
                return cell
            }
            sectionModel.cellModelsArr.append(selectDetailCellmodel)
        }
        
    }
}
