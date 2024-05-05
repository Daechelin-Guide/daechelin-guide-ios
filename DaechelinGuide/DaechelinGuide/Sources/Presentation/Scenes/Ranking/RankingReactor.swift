//
//  RankingReactor.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import Foundation
import ReactorKit

final class RankingReactor: Reactor {
    
    // MARK: - Properties
    var initialState: State = State()
    
    // MARK: - Action
    enum Action {
        case refresh
        case fetchRanking
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setMealType(MealType)
        case setRanking(RankingResponse?)
    }
    
    // MARK: - State
    struct State {
        var mealType: MealType = .TYPE_BREAKFAST
        var ranking: RankingResponse?
    }
}

// MARK: - Mutate
extension RankingReactor {
    
    private func fetchRanking() -> Observable<Mutation> {
        return RankingProvider.shared
            .getRating(currentState.mealType)
            .flatMap { result -> Observable<Mutation> in
                switch result {
                case .success(let data):
                    return Observable.just(.setRanking(data))
                case .failure(_):
                    return Observable.just(.setRanking(nil))
                }
            }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .empty()
            
        case .fetchRanking:
            return fetchRanking()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setMealType(let mealType):
            newState.mealType = mealType
            
        case .setRanking(let ranking):
            newState.ranking = ranking
        }
        return newState
    }
}

