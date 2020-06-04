//
//  Date+Extension.swift
//  JZStar
//
//  Created by don on 2019/9/4.
//  Copyright © 2019 don. All rights reserved.
//

extension Date: SSCompatible {}
extension SS where Base == Date {
    /// 日期字符串转化为Date类型
    ///
    /// - Parameters:
    ///   - string: 日期字符串
    ///   - dateFormat: 格式化样式，默认为“yyyy-MM-dd HH:mm:ss”
    static func stringConvertDate(string:String, dateFormat:String="HH:mm") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: string)
        return date!
    }
}
