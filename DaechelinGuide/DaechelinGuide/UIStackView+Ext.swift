//
//  UIStackView+Ext.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}
