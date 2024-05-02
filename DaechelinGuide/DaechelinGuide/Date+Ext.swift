//
//  Date+Ext.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import Foundation

extension Date {
    
    func formattingDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
}
