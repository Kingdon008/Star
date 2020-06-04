//
//  ColorExtension.swift
//  JZStar
//
//  Created by don on 2018/11/23.
//  Copyright © 2018 zhouqitian. All rights reserved.
//

extension UIColor: SSCompatible {}
extension SS where Base:UIColor {
    static func rgbColor(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ alpha:CGFloat = 1.0) -> UIColor{
        let color:UIColor = UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
        return color
    }

    static func randomColor() -> UIColor {
        return UIColor(red: randomColorCount(0, 256)/255.0, green: randomColorCount(0, 256)/255.0, blue: randomColorCount(0, 256)/255.0, alpha: 1.0)
    }

    private static func randomColorCount(_ startIndex:Int, _ endIndex:Int) -> CGFloat{
        let range = Range<Int>(startIndex...endIndex)
        let count = UInt32(range.upperBound - range.lowerBound)
        let v = Int(arc4random_uniform(count))+range.lowerBound
        return CGFloat(v)
    }

    static func colorWithHexString(_ stringToConvert: String) -> UIColor {
        let scanner = Scanner(string: stringToConvert)
        var hexNum: UInt32 = 0
        guard scanner.scanHexInt32(&hexNum) else {
            return UIColor.red
        }
        return UIColor.ss.colorWithRGBHex(hexNum)
    }

    static func colorWithRGBHex(_ hex: UInt32) -> UIColor {
        let r = (hex >> 16) & 0xFF
        let g = (hex >> 8) & 0xFF
        let b = (hex) & 0xFF
        return UIColor(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: 1.0)
    }
    
    //rgb色差
    static func getRGBDictionaryByColor(_ color: UIColor) -> [CGFloat] {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        let components = color.cgColor.components
        r = components![0]
        g = components![1]
        b = components![2]
        a = components![3]
        return [r, g, b, a]
    }
    
    //渐变色
    static func drawWithColors(colors:[CGColor]) -> CAGradientLayer{
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        return gradientLayer
    }
    
    /// 根据颜色生成图片
    /// - Parameter color: UIColor
    static func getImageWithColor(color: UIColor) -> UIImage {
        let defaultImage = UIImage()
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        //获取位图上下文
        UIGraphicsBeginImageContext(rect.size)
        //获取当前上下文
        guard let contex = UIGraphicsGetCurrentContext() else {
            return defaultImage
        }
        //设置填充色
        contex.setFillColor(color.cgColor)
        //设置填充区域
        contex.fill(rect)
        //从位图上下文获取图片
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return defaultImage
        }
        //关闭位图上下文
        UIGraphicsEndImageContext()
        return image
    }
    
    static func rgbColor(r:CGFloat, g:CGFloat, b:CGFloat) ->UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    static func rgbA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}

