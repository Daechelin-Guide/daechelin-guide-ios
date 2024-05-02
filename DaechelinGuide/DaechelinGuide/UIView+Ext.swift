//
//  UIView+Ext.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subView: UIView...) {
        subView.forEach(addSubview(_:))
    }
}
