//
//  UIColor+Ext.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/1/24.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted
        )
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        self
            .init(
                red: CGFloat(int >> 16) / 255,
                green: CGFloat(int >> 8 & 0xFF) / 255,
                blue: CGFloat(int & 0xFF) / 255,
                alpha: 1
            )
    }
    
    func darken(by percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        red = max(0.0, min(1.0, red - percentage))
        green = max(0.0, min(1.0, green - percentage))
        blue = max(0.0, min(1.0, blue - percentage))
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
