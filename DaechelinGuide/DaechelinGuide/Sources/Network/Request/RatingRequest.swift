//
//  RatingRequest.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/4/24.
//

import Foundation

struct RatingRequest: Codable {
    let score: Int
    let comment: String?
}
