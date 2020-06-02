//
//  NSString+Extension.swift
//  StellarHomeIOS
//
//  Created by don on 2019/6/3.
//  Copyright © 2019 don. All rights reserved.
//

extension String: SSCompatible {}
extension SS where Base == String {
    static let detailFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    ///  计算文字高度
    /// - Parameters:
    ///   - text: 文字
    ///   - font: 字体大小
    ///   - size: 最大宽度
    static func getTextRectSize(text:String,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }
    
    /// Date类型转化为日期字符串
    ///
    /// - Parameters:
    ///   - date: Date类型
    ///   - dateFormat: 格式化样式默认“yyyy-MM-dd”
    /// - Returns: 日期字符串
    static func dateConvertString(date:Date, dateFormat:String="HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
    
    static func UTCStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = detailFormat
        return dateFormatter.string(from: date).appending("Z")
    }
    
    static func localTimeWithUTCString(UTCtimeString: String) -> String {
        if UTCtimeString.isEmpty {
            return UTCtimeString
        }
        var timeString = UTCtimeString
        timeString.removeLast() //去掉最后的 Z
        let utcFormatter = DateFormatter()
        utcFormatter.locale = Locale(identifier: "en_US_POSIX")
        utcFormatter.timeZone = TimeZone(abbreviation: "GMT")
        utcFormatter.dateFormat = detailFormat
        
        let date = utcFormatter.date(from: timeString)
        let localFormatter = DateFormatter()
        localFormatter.dateFormat = "HH:mm"
        
        let localTimeString = localFormatter.string(from: date!)
        return localTimeString
    }
    
    /// 计算当前时间与智能倒计时开启时间的差    UTCtimeString: 服务器返回的智能开启时间
    static func getTimeralWithUTCString(UTCtimeString: String) -> Int {
        let arr = UTCtimeString.components(separatedBy: ".")
        let utcFormatter = DateFormatter()
        utcFormatter.locale = Locale(identifier: "en_US_POSIX")
        utcFormatter.timeZone = TimeZone(abbreviation: "GMT")
        utcFormatter.dateFormat = detailFormat
        let date = utcFormatter.date(from: arr[0])
        let timeral = date?.timeIntervalSinceNow
        return Int(-timeral!)
    }
    
    /// 把当前时间设置成智能开启时间 与服务器返回的格式一致
    static func getUTCEnableTimeWithNow() -> String {
        let date = Date()
        let utcFormatter = DateFormatter()
        utcFormatter.locale = Locale(identifier: "en_US_POSIX")
        utcFormatter.timeZone = TimeZone(abbreviation: "GMT")
        utcFormatter.dateFormat = detailFormat
        return utcFormatter.string(from: date).appending(".000Z")
    }
    
    /// 获取当前时间与 时间戳 hh:mm 的时间差 (默认今天)
    /// - timeString: hh:mm 格式的时间戳
    static func getTodayTimeralWithString(timeString: String) ->Int {
        let dateNow = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        dateformatter.timeZone = NSTimeZone.local
        dateformatter.locale = Locale(identifier: "zh_CN")
        let timeNow = dateformatter.string(from: dateNow)
        let restTime = timeNow+" \(timeString):00"
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let restDate = dateformatter.date(from: restTime) ?? Date()
        let timeral = restDate.timeIntervalSinceNow
        return Int(timeral)
    }
    

    /**
     正则表达式获取目的值
     - parameter pattern: 一个字符串类型的正则表达式
     - parameter str: 需要比较判断的对象
     - imports: 这里子串的获取先转话为NSString的[以后处理结果含NS的还是可以转换为NS前缀的方便]
     - returns: 返回目的字符串结果值数组(目前将String转换为NSString获得子串方法较为容易)
     */
    private static func regexGetSub(pattern:String, str:String) -> [String] {
        var subStr = [String]()
        let regex = try? NSRegularExpression(pattern: pattern, options:[])
        guard let matches = regex?.matches(in: str, options: [], range: NSRange(str.startIndex...,in: str)) else { return subStr }
        //解析出子串
        for match in matches{
            if let matchRange = Range.init(match.range(at: 1), in: str){
                let matchStr: String = String.init(str[matchRange])
                subStr.append(matchStr)
            }
            
        }
        return subStr
    }
    
    
    /// 截取引号中的文字
    /// - Parameter str: 需要比较判断的对象
    static func getQuotationMarksString(str: String) -> [String]{
        var finalString = str.replacingOccurrences(of: "“", with: "\"")
        finalString = finalString.replacingOccurrences(of: "”", with: "\"")
        let pattern = "\"(.*?)\""
        return String.ss.regexGetSub(pattern: pattern, str: finalString)
    }
    
    private static func validationExpression(pattern:String,checkString:String) -> Bool{
        /// 正则规则
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        /// 进行正则匹配
        let results = regex?.matches(in: checkString, options: [], range: NSRange(location: 0, length: checkString.count))
        if (results?.count ?? 0) > 0{
            return true
        }else{
            return false
        }
    }
    
    func hexTodec() -> String {
        let str = base.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return "\(sum)"
    }
}


