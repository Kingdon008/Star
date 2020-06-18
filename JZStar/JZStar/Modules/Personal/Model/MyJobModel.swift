//
//  MyJobModel.swift
//  JZStar
//
//  Created by don on 2020/6/18.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyJobModel: Convertible {
    var name:String?
    var status_id:String?
    var data = [DetailMerchantModel]()
    
    required public init() {
        // Intentionally unimplemented...
    }
}
