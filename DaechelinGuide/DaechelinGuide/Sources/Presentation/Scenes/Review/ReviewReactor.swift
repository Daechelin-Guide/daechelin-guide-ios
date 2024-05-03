//
//  ReviewReactor.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import Foundation
import ReactorKit

final class ReviewReactor: Reactor {
    
    // MARK: - Properties
    var initialState: State = State()
    
    // MARK: - Action
    enum Action {
        case completeReview
        case setReviewText(String)
        case setReviewScore(Double)
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setReviewText(String)
        case setReviewScore(Double)
    }
    
    // MARK: - State
    struct State {
        var reviewText: String = ""
        var score: Double = 0.0
    }
}

// MARK: - Mutate
extension ReviewReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case let .setReviewText(text):
            return .just(.setReviewText(text))
            
        case let .setReviewScore(rating):
            return .just(.setReviewScore(rating))
            
        case .completeReview:
            return .empty()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setReviewText(let reviewText):
            newState.reviewText = reviewText
            
        case .setReviewScore(let score):
            newState.score = score
        }
        return newState
    }
}
