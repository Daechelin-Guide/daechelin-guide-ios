//
//  MenuDetailResponse.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/1/24.
//

import Foundation

struct MenuDetailResponse: Codable {
    let id: Int
    let menu: String?
    let date: String
    let cal: String?
    let totalScore: Double
    let nutrients: String?
    let mealType: MealType
}
