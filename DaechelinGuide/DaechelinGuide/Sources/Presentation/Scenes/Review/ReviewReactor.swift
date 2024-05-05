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
    var initialState: State
    
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
        var menuId: Int
        var reviewText: String = ""
        var score: Double = 0.0
    }
    
    init(menuId: Int) {
        self.initialState = State(menuId: menuId)
    }
}

// MARK: - Mutate
extension ReviewReactor {
    
    private func postReview() -> Observable<Mutation> {
        
        return RatingProvider.shared
            .postRating(
                currentState.menuId,
                RatingRequest(score: currentState.score, comment: currentState.reviewText)
            )
            .flatMap { result -> Observable<Mutation> in
                switch result {
                case .success(_):
                    return Observable.empty()
                case .failure(_):
                    return Observable.empty()
                }
            }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case let .setReviewText(text):
            return .just(.setReviewText(text))
            
        case let .setReviewScore(rating):
            return .just(.setReviewScore(rating))
            
        case .completeReview:
            return postReview()
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
