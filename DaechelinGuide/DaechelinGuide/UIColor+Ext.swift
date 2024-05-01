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
        self.init(
            red: CGFloat(int >> 16) / 255,
            green: CGFloat(int >> 8 & 0xFF) / 255,
            blue: CGFloat(int & 0xFF) / 255,
            alpha: 1
        )
    }
}
