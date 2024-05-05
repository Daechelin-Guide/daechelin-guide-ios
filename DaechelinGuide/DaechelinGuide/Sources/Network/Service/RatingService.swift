//
//  RatingService.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/5/24.
//

import Foundation
import Moya

enum RatingService {
    case getRating(_ menuId: Int)
    case postRating(_ menuId: Int, _ request: RatingRequest)
}

extension RatingService: TargetType {
    
    var baseURL: URL {
        return URL(string: apiUrl + "/rating")!
    }
    
    var path: String {
        switch self {
        case .getRating(let menuId):
            return "/\(menuId)"
        case .postRating(let menuId, _):
            return "/\(menuId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRating(_):
            return .get
        case .postRating(_, _):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getRating(_):
            return .requestPlain
        case let .postRating(_, request):
            let params = request.comment.isEmpty
            ? ["score": request.score]
            : ["score": request.score, "comment": request.comment]
            return .requestParameters(
                parameters: params,
                encoding: JSONEncoding.default
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
