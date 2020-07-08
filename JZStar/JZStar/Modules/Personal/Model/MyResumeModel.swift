//
//  MyResumeModel.swift
//  JZStar
//
//  Created by don on 2020/6/19.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

public class MyResumeModel: Convertible {
    var interest_profession = [SequenceModel]()
    var education = [SequenceModel]()
    var resume = ResumeModel()
    
    required public init() {
        // Intentionally unimplemented...
    }
}

public class SequenceModel: Convertible {
    var name:String?
    var id:Int?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

public class ResumeModel: Convertible {
    var uid:String?
    var name:String?
    var sex:Int?
    var age:String?
    var education_id:Int?
    var education:String?
    var major:String?
    var interest_profession_id:Int?
    var interest_profession:String?
    var personal_description:String?
    var is_attestation:Int?
    var interest_online:Bool = false
    var interest_work_place:String?
    
    required public init() {
        // Intentionally unimplemented...
    }
}

