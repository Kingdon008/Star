//
//  DetailWorksModel.swift
//  JZStar
//
//  Created by herodon on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MerchantModel: Convertible {
    var data:[MerchantClassifyModel]?
    var status:Bool?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

class MerchantClassifyModel: Convertible {
    var name:String?
    var id:Int?
    var data:[DetailMerchantModel]?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

class DetailMerchantModel: Convertible {
    var id:Int?
    var title:String?
    var company_name:String?
    var salary_describe:String?
    var is_fulltime:Bool?
    var is_parttime:Bool?
    var tag_name:String?
    
    required public init() {
        // Intentionally unimplemented...
    }
}
