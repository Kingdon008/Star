//
//  DetailPositionModel.swift
//  JZStar
//
//  Created by don on 2020/6/17.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class DetailPositionModel: Convertible {
    var company_icon:String?
    var id:Int?
    var tag_name:DetailMerchantTagNameModel?
    var company_name:String?
    var salary_describe:String?
    var company_qq:String?
    var company_score:String?
    var content:String?
    var title:String?
    var is_fulltime:Bool?
    var is_parttime:Bool?
    
    required public init() {
        // Intentionally unimplemented...
    }
}
