//
//  NSDictionary+Extension.swift
//  JZStar
//
//  Created by don on 2019/11/25.
//  Copyright © 2019 don. All rights reserved.
//


extension NSDictionary {
    
    func toJson() -> JSON?{
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let json =  try? JSON(data: data)
            return json
        }catch let error {
            print(error)
            return nil
        }
    }
}
