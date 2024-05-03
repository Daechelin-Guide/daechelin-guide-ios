//
//  UILabel+Ext.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/3/24.
//

import UIKit

extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, alignment: NSTextAlignment = .center) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = 0
        paragraphStyle.alignment = alignment
        
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        self.attributedText = attributedString
    }
}
