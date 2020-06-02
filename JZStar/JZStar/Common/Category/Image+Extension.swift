//
//  ImageExtension.swift
//  Stellar Wi-Fi
//
//  Created by 周奇天 on 2018/11/23.
//  Copyright © 2018 zhouqitian. All rights reserved.
//

extension UIImage: SSCompatible {}
extension SS where Base:UIImage {
    //生成圆形图片
    func toCircle() -> UIImage {
        let originalImage = base as UIImage
        //取最短边长
        let shotest = min(originalImage.size.width, originalImage.size.height)
        //输出尺寸
        let outputRect = CGRect(x: 0, y: 0, width: shotest, height: shotest)
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可）
        UIGraphicsBeginImageContextWithOptions(outputRect.size, false, 0)
        let context = UIGraphicsGetCurrentContext()!
        //添加圆形裁剪区域
        context.addEllipse(in: outputRect)
        context.clip()
        //绘制图片
        originalImage.draw(in: CGRect(x: (shotest-originalImage.size.width)/2,
                             y: (shotest-originalImage.size.height)/2,
                             width: originalImage.size.width,
                             height: originalImage.size.height))
        //获得处理后的图片
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return maskedImage
    }

    func reSizeImage(reSize:CGSize)->UIImage {
        let originalImage = base as UIImage
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        originalImage.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    static func reSizeImage(reSize:CGSize,image:UIImage)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        image.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return reSizeImage
    }

}

