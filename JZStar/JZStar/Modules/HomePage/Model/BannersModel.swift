//
//  BannersModel.swift
//  JZStar
//
//  Created by don on 2020/6/5.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class BannersModel: Convertible {
    var banners:[BannerModel]?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

class BannerModel: Convertible {
    var id:Int?
    var img_url:String?
    
    required public init() {
        // Intentionally unimplemented...
    }
}


