//
//  HexConverter.swift
//  CupcakeCorner-iOS
//
//  Created by Aaryan Kothari on 10/11/20.
//

import UIKit
import SwiftUI


extension Color {
    init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(UIColor.init(red : r/255, green : g/255, blue: b/255, alpha: 1))
    }
    
    
    //MARK: HEX COLOR
    init(hexString:String) {
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(UIColor(red: red, green: green, blue: blue, alpha: 1))
    }
}
