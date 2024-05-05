//
//  MenuService.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/4/24.
//

import Foundation
import Moya

enum MenuService {
    case getMenu(_ date: String)
    case getMenuDatail(_ date: String, _ mealType: MealType)
}

extension MenuService: TargetType {
    
    var baseURL: URL {
        return URL(string: apiUrl + "/menu")!
    }
    
    var path: String {
        switch self {
        case .getMenu(_):
            return ""
        case .getMenuDatail(_, _):
            return "/detail"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMenu(_):
            return .get
        case .getMenuDatail(_, _):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getMenu(date):
            return .requestParameters(
                parameters: ["date": date],
                encoding: URLEncoding.default
            )
        case let .getMenuDatail(date, mealType):
            return .requestParameters(
                parameters: ["date": date, "mealType": mealType],
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
