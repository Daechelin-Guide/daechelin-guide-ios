//
//  RankingService.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/5/24.
//

import Foundation
import Moya

enum RankingService {
    case getRanking(_ mealType: MealType)
}

extension RankingService: TargetType {
    
    var baseURL: URL {
        return URL(string: apiUrl + "/ranking")!
    }
    
    var path: String {
        switch self {
        case .getRanking(_):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRanking(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getRanking(mealType):
            return .requestParameters(
                parameters: ["mealType": mealType],
                encoding: URLEncoding.default
            )
        }
    }
    
    var validationType: Moya.ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        return headers
    }
}
