//
//  MenuResponse.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/1/24.
//

import Foundation

struct MenuResponse: Codable {
    let date: String
    let breakfast: String?
    let lunch: String?
    let dinner: String?
}
