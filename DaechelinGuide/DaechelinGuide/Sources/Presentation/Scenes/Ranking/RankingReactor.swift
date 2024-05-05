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
        case setMealType(MealType)
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setMealType(MealType)
        case setBreakfastRanking(RankingResponse?)
        case setLunchRanking(RankingResponse?)
        case setDinnerRanking(RankingResponse?)
    }
    
    // MARK: - State
    struct State {
        var mealType: MealType = .TYPE_LUNCH
        var breakfastRanking: RankingResponse?
        var lunchRanking: RankingResponse?
        var dinnerRanking: RankingResponse?
    }
}

// MARK: - Mutate
extension RankingReactor {
    
    private func fetchBreakfastRanking() -> Observable<Mutation> {
        return RankingProvider.shared
            .getRating(.TYPE_BREAKFAST)
            .map { result -> Mutation in
                switch result {
                case .success(let data):
                    return .setBreakfastRanking(data)
                case .failure:
                    return .setBreakfastRanking(nil)
                }
            }
    }
    
    private func fetchLunchRanking() -> Observable<Mutation> {
        return RankingProvider.shared
            .getRating(.TYPE_LUNCH)
            .map { result -> Mutation in
                switch result {
                case .success(let data):
                    return .setLunchRanking(data)
                case .failure:
                    return .setLunchRanking(nil)
                }
            }
    }
    
    private func fetchDinnerRanking() -> Observable<Mutation> {
        return RankingProvider.shared
            .getRating(.TYPE_DINNER)
            .map { result -> Mutation in
                switch result {
                case .success(let data):
                    return .setDinnerRanking(data)
                case .failure:
                    return .setDinnerRanking(nil)
                }
            }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .empty()
            
        case .fetchRanking:
            let breakfastObservable = fetchBreakfastRanking()
            let lunchObservable = fetchLunchRanking()
            let dinnerObservable = fetchDinnerRanking()
            
            return Observable.merge(breakfastObservable, lunchObservable, dinnerObservable)
            
        case .setMealType(let mealType):
            return .just(.setMealType(mealType))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setMealType(let mealType):
            newState.mealType = mealType
            
        case .setBreakfastRanking(let ranking):
            newState.breakfastRanking = ranking
            
        case .setLunchRanking(let ranking):
            newState.lunchRanking = ranking
            
        case .setDinnerRanking(let ranking):
            newState.dinnerRanking = ranking
        }
        return newState
    }
}

