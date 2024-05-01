//
//  MealResponse.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/1/24.
//

import Foundation

struct MealResponse: Decodable {
    let id: Int
    let menu: String?
    let date: String
    let cal: String?
    let totalScore: Int
    let nutrients: String?
    let mealType: MealType
}
