//
//  MyResumeModel.swift
//  JZStar
//
//  Created by don on 2020/6/19.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class MyResumeModel: Convertible {
    var interest_profession:[SequenceModel]?
    var education:[SequenceModel]?
    var resume:String?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

class SequenceModel: Convertible {
    var name:String?
    var id:Int?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

