//
//  Global.swift
//  AKWeather
//
//  Created by 李亚坤 on 2017/9/7.
//  Copyright © 2017年 Kuture. All rights reserved.
//

import UIKit

/*
 * 设备尺寸
 */
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/*
 * Token
 */
let USERTOKEN:String = UserDefaults.standard.object(forKey: "LoginToken") as! String

/*
 * ALIGN
 */
let ALIG_LEFT = NSTextAlignment.left
let ALIG_RIGHT = NSTextAlignment.right
let ALIG_CENTER = NSTextAlignment.center

/*
 * FONT
 */
public func FONT_S( _ s:CGFloat) -> UIFont {
    
    let S = s
    
    return UIFont.systemFont(ofSize: S)
}

//#define COLORS_HEX(s,a) [UIColor colorWithRed:((float)((s & 0xFF0000) >> 16))/255.0 green:((float)((s & 0xFF00) >>8))/255.0 blue:((float)(s & 0xFF))/255.0 alpha:a]

/**
 * 十六进制颜色
 */

/**
 * RGB颜色
 */
public func COLORS_RGB( _ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
    
    let red = r / 255.0
    let green = g / 255.0
    let blue = b / 255.0
    
    return UIColor.init(red: red, green: green, blue: blue, alpha: a)
}

/**
 * 随机颜色
 */
public func COLORS_RANDOM( _ a:CGFloat) -> UIColor {
    
    let red = CGFloat (arc4random_uniform(255)) / 255.0
    let green = CGFloat (arc4random_uniform(255)) / 255.0
    let blue = CGFloat (arc4random_uniform(255)) / 255.0
    
    return UIColor.init(red: red, green: green, blue: blue, alpha: a)
}

/**
 * 相同颜色
 */
public func COLORS_SAME( _ n:CGFloat,_ a:CGFloat) -> UIColor {
    
    let ncolor = n / 255.0
    
    return UIColor.init(red: ncolor, green: ncolor, blue: ncolor, alpha: a)
}

//常用颜色
let BLUE_HARD = COLORS_RGB(15,58,121,1)
let BLUE_LOW = COLORS_RGB(25, 154, 255, 1)
let COLORS_BLUE = COLORS_RGB(15,58,121, 1)

extension UIColor {
    
    convenience init ( _ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat){
        
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
}

































