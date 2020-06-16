//
//  DetailWorksModel.swift
//  JZStar
//
//  Created by herodon on 2020/6/3.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MerchantModel: Convertible {
   var name:String?
    var id:Int?
    var data = [DetailMerchantModel]()
    
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
    var tag_name:DetailMerchantTagNameModel?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

class DetailMerchantTagNameModel: Convertible {
    var type1:[String]?
    var type2:[String]?
    
    required public init() {
        // Intentionally unimplemented...
    }
}
