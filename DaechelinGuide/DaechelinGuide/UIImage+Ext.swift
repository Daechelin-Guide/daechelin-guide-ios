//
//  UIImage+Ext.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import UIKit

extension UIImage {
    
    convenience init?(icon: Icon) {
        self
            .init(named: icon.rawValue)
    }
}
