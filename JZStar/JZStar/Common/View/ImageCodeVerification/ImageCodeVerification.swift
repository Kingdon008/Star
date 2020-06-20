//
//  ImageCodeVerification.swift
//  JZStar
//
//  Created by herodon on 2020/6/20.
//  Copyright © 2020 don. All rights reserved.
//

import UIKit

class ImageCodeVerification: NSObject {
    
    static func create(_ frame: CGRect) -> (obj: UIControl, code: String) {
        let code = getCode()
        let view = getView(frame, code)
        return (view, code)
    }

    private override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func getCode() -> String {
        let codeArray =  ["0","1","2","3","4","5","6","7","8","9"]
//        var codeArray =  ["0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        var codeStr = ""
        for _ in 0 ..< 4 {
            let i = (Int)(arc4random()) % (codeArray.count-1)
            let str = codeArray[i]
            codeStr.append(str)
        }
        return codeStr
    }

    private static func getView(_ frame: CGRect, _ codeStr: String) -> UIControl {
        let view = UIControl(frame: frame)
        var randWidth = frame.width/CGFloat(codeStr.count)/5
        var randHeight = frame.height/5
        if randWidth < 1 {
            randWidth = 1
        }
        if randHeight < 1 {
            randHeight = 1
        }
        let textSize = CGSize(width: frame.width/CGFloat(codeStr.count), height: frame.height/2)
        let isRotation = true
        //创建放置验证码的label
        for i in 0 ..< codeStr.count {
            let pxx = arc4random() % UInt32(randWidth)
            let px = CGFloat(pxx) + CGFloat(i)*(frame.size.width-3)/CGFloat(codeStr.count)
            let py = arc4random() % UInt32(randHeight)
            let label = UILabel.init(frame: CGRect.init(x: px + 3, y: CGFloat(py), width: textSize.width, height: textSize.height))
            let slice = codeStr[codeStr.index(codeStr.startIndex, offsetBy: i) ..< codeStr.index(codeStr.startIndex, offsetBy: i+1)]
            label.text = String.init(slice)
            label.font = UIFont.systemFont(ofSize: 20)
            if (isRotation == true) {
                let a = arc4random() % UInt32(60)
                let r = Double(a)-30
                label.transform = CGAffineTransform.init(rotationAngle: CGFloat(r*Double.pi)/180)
            }
            view.addSubview(label)
        }
        //随机划线
        for _ in 0...9 {
            let path = UIBezierPath.init()
            let pX = arc4random() % UInt32(view.frame.width)
            let pY = arc4random() % UInt32(view.frame.height)
            path.move(to: CGPoint.init(x: CGFloat(pX), y: CGFloat(pY)))
            let ptX = arc4random() % UInt32(view.frame.width)
            let ptY = arc4random() % UInt32(view.frame.height)
            path.addLine(to: CGPoint.init(x: CGFloat(ptX), y: CGFloat(ptY)))
            let layer = CAShapeLayer.init()
            layer.strokeColor = UIColor.init(white: (CGFloat(arc4random() % 100)/100.0), alpha: 1).cgColor
            layer.lineWidth = 1.0
            layer.strokeEnd = 1
            layer.fillColor = UIColor.clear.cgColor
            layer.path = path.cgPath
            view.layer.addSublayer(layer)
        }
        return view
    }
    
    func refresh(){
        
    }

}
