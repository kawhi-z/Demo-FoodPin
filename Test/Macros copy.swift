//
//  SwiftMacros.swift
//  QQMailApp0.9.1
//
//  Created by Neil on 2019/8/26.
//  Copyright © 2019 QQMail. All rights reserved.
//
import UIKit
import Foundation

// support ios8.0+

// MARK: Geometry
func ScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.size.height
}

func ScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.size.width
}

func ScreenScale() -> CGFloat {
    return UIScreen.main.scale
}

func PixelOne() -> CGFloat {
    return 1.0 / ScreenScale()
}

func IsLandscape() -> Bool {
    return UIApplication.shared.statusBarOrientation.isLandscape
}

func StatusBarHeight() -> CGFloat {
    return UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.size.height
}

func NavigationBarHeight() -> CGFloat {
    return SystemVersion() >= 12.0 ? 50.0 : 44.0
}

//func ToolBarHeight() -> CGFloat {
////    return IsLandscape() ? (IsiPhoneX ? 51 : QMUIHelper.is55InchScreen() ? 44 : 32) : (IsiPhoneX ? 83 :44)
//}

func VCHeightWithoutNavigationBar() -> CGFloat {
    return ScreenHeight() - NavigationBarHeight()
}

func Angle(degress: CGFloat) -> CGFloat {
    return CGFloat(Double.pi) * degress / 180.0
}



// MARK: Color & Font
func Font(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func Font(_ size: CGFloat, _ weight: UIFont.Weight) -> UIFont {
    return UIFont.systemFont(ofSize: size, weight: weight)
}

//func DynamicFont(_ size: CGFloat) -> UIFont {
//    return UIFont.qmui_dynamicSystemFont(ofSize: size, weight: QMUIFontWeight.normal, italic: false)
//}
//
//func DynamicFont(_ size: CGFloat, _ weight: QMUIFontWeight) -> UIFont {
//    return UIFont.qmui_dynamicSystemFont(ofSize: size, weight: weight, italic: false)
//}
//
//func Color(_ key: String) -> UIColor {
//    return FMThemeManager.dynamicColor(withKey: key)
//}
//
//func Color(_ key: String, _ a: CGFloat) -> UIColor {
//    return FMThemeManager.dynamicColor(withKey: key, alpha: a)
//}
//
//func AbsoluteColor(_ key: String) -> UIColor {
//    return FMThemeManager.absoluteColor(withKey: key)
//}
//
//func AbsoluteColor(_ key: String, _ a: CGFloat) -> UIColor {
//    return FMThemeManager.absoluteColor(withKey: key, alpha: a)
//}
//
//func RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
//    return FMThemeManager.dynamicColor(withRed: r, green: g, blue: b, alpha: 1.0)
//}
//
//func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
//    return FMThemeManager.dynamicColor(withRed: r, green: g, blue: b, alpha: a)
//}

func AbsoluteRGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

func Localize(_ key: String) -> String {
    return NSLocalizedString(key, comment: key)
}

func Image(_ name: String) -> UIImage? {
    return UIImage(named: name)
}

// MARK: Device
func SystemVersion() -> CGFloat {
    return CGFloat((UIDevice.current.systemVersion as NSString).floatValue)
}

let IsiPhoneX: Bool = {
    return UIScreen.instancesRespond(to: #selector(getter: UIScreen.main.currentMode)) ? UIScreen.main.currentMode!.size.height / UIScreen.main.currentMode!.size.width > 2.15 : false
}()




// MARK:  Quick Make
func Edge(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets {
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

func Rect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func Size(_ w: CGFloat, _ h: CGFloat) -> CGSize {
    return CGSize(width: w, height: h)
}

func Point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
}

/// 根据常用属性获取一个 UIView 对象
func View(backgroundColor: UIColor?) -> UIView {
    let v: UIView = UIView()
    v.backgroundColor = backgroundColor
    return v
}

/// 根据常用属性获取一个 UILabel 对象
func Label(font: UIFont?, textColor: UIColor?, textAlignment: NSTextAlignment?) -> UILabel {
    let v: UILabel = UILabel()
    if font != nil {
        v.font = font!
    }
    if textColor != nil {
        v.textColor = textColor!
    }
    if textAlignment != nil {
        v.textAlignment = textAlignment!
    }
    return v
}

/// 根据常用属性获取一个 UIButton 对象
//func Button(font: UIFont?, normalTextColor: UIColor?, normalBackgroundColor: UIColor?, highlightedBackgroundColor: UIColor?) -> UIButton {
//    let v: UIButton = UIButton(type: .custom)
//    v.setTitleColor(normalTextColor, for: .normal)
//    if font != nil {
//        v.titleLabel?.font = font!
//    }
//    if normalBackgroundColor != nil {
//        v.setBackgroundImage(UIImage.qmui_image(with: normalBackgroundColor), for: .normal)
//    }
//    if highlightedBackgroundColor != nil {
//        v.setBackgroundImage(UIImage.qmui_image(with: normalBackgroundColor), for: .highlighted)
//    }
//
//    return v
//}



// MARK: GCD
/// 在主线程同步执行 block
func DispatchMainSync(_ cb:@escaping ()->()) {
    if Thread.isMainThread {
        cb()
    } else {
        DispatchQueue.main.sync(execute: cb)
    }
}

/// 在主线程异步执行 block
func DispatchMainAsync(_ cb:@escaping ()->()) {
    if Thread.isMainThread {
        cb()
    } else {
        DispatchQueue.main.async(execute: cb)
    }
}

/// 在主线程异步延时执行 block
func DispatchMainAsyncAfter(_ afterInterval: Double, _ cb:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(afterInterval * 1000)), execute: cb)
}



// MARK: Log
/// Log
//func LogError(_ msg: String) {
//    QZLogger.instance()?.log(Int(QZLogLevel_Error.rawValue), file: #file, func: #function, line: #line, string: msg)
//}
//
//func LogWarning(_ msg: String) {
//    QZLogger.instance()?.log(Int(QZLogLevel_Warning.rawValue), file: #file, func: #function, line: #line, string: msg)
//}
//
//func LogDebug(_ msg: String) {
//    QZLogger.instance()?.log(Int(QZLogLevel_Debug.rawValue), file: #file, func: #function, line: #line, string: msg)
//}
//
//func LogInfo(_ msg: String) {
//    QZLogger.instance()?.log(Int(QZLogLevel_Info.rawValue), file: #file, func: #function, line: #line, string: msg)
//}
//
//func SafeAreaInsets() -> UIEdgeInsets {
//    QMUIHelper.safeAreaInsetsForIPhoneX()
//}

// MARK: ViewExtension
extension UIView {
    func left() -> CGFloat {
        return self.frame.minX
    }
    
    func width() -> CGFloat {
        return self.frame.width
    }
    
    func right() -> CGFloat {
        return self.frame.maxX
    }
    
    func top() -> CGFloat {
        return self.frame.minY
    }
    
    func height() -> CGFloat {
        return self.frame.height
    }
    
    func bottom() -> CGFloat {
        return self.frame.maxY
    }
}
