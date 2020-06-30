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
    static var APP_NAME:String   = "Hiraafood"
    static var FONT_TITLE:UIFont = UIFont(name: "HelveticaNeue-medium", size: CGFloat(24))!

    static var COLOR_0:UIColor = UIColor(hex:"#264E86FF")!
    static var COLOR_1:UIColor = UIColor(hex:"#5E88FCFF")!
    static var COLOR_2:UIColor = UIColor(hex:"#74DBEFFF")!
    static var COLOR_3:UIColor = UIColor(hex:"#AFFFFFFF")!

    
    static var TOP_MARGIN:CGFloat    = CGFloat(20)
    static var LEFT_MARGIN:CGFloat   = CGFloat(20)
    static var RIGHT_MARGIN:CGFloat  = CGFloat(20)
    static var BOTTOM_MARGIN:CGFloat  = CGFloat(20)

    static var ROW_HEIGHT:CGFloat   = CGFloat(100)
    static var IMAGE_HEIGHT:CGFloat = CGFloat(100)
    static var LABEL_HEIGHT:CGFloat = CGFloat(24)
    static var LINE_HEIGHT:CGFloat = CGFloat(24)

    static var VGAP:CGFloat = CGFloat(24)
    static var HGAP:CGFloat = CGFloat(12)
    
    static var BUTTON_WIDTH:CGFloat = CGFloat(200)
    static var BUTTON_HEIGHT:CGFloat = CGFloat(12)
}
extension UIColor {
    /*
     * Given a Hexadecimal color code create UIColor
     */
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        print("creating color with code \(hex)")
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    print("creating color red:\(r) green:\(g) blue:\(b) alpha:\(a)")
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
