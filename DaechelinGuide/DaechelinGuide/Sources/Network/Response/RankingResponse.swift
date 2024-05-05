//
//  RankingResponse.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/5/24.
//

import Foundation

struct RankingResponse: Codable {
    let ranking: [Ranking]
}

struct Ranking: Codable {
    let id: Int
    let menu: String
    let date: String
    let cal: String
    let totalScore: Double
    let ranking: Int
}
