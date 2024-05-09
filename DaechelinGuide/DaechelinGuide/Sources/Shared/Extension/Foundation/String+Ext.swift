//
//  String+Ext.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/8/24.
//

import Foundation

extension String {
    
    func stringToDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.date(from: self) ?? Date()
    }
}
