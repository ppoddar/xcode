//
//  UIConstants.swift
//  hiraafood
//
//  Created by Pinaki Poddar on 6/21/20.
//  Copyright © 2020 Digital Artisan. All rights reserved.
//

import Foundation
import UIKit
struct UIConstants {
    static var APP_NAME:String       = "Hiraafood"
    
    static var ROW_HEIGHT:CGFloat   = CGFloat(100)
    static var IMAGE_HEIGHT:CGFloat = CGFloat(100)
    static var LABEL_HEIGHT:CGFloat = CGFloat(24)
    static var LINE_HEIGHT:CGFloat  = CGFloat(24)

    static var VGAP:CGFloat = CGFloat(24)
    static var HGAP:CGFloat = CGFloat(12)
    
    static var BUTTON_WIDTH:CGFloat  = CGFloat(200)
    static var BUTTON_HEIGHT:CGFloat = CGFloat(36)
    
    static var COLOR_HIGHLIGHT = UIColor(hexString: "#EDC7B7", alpha: 1.0)
    static var COLOR_NORMAL    = UIColor(hexString: "#EEE2DC", alpha: 1.0)
    static var COLOR_MUTED     = UIColor(hexString: "#BAB2B5", alpha: 1.0)
    static var COLOR_TITLE     = UIColor(hexString: "#123C69", alpha: 1.0)
    static var COLOR_DANGER    = UIColor(hexString: "#AC3B61", alpha: 1.0)

}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

