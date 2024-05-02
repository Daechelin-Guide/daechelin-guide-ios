//
//  HomeViewReactor.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import Foundation
import ReactorKit

final class HomeViewReactor: Reactor {
    
    // MARK: - Properties
    var initialState: State = State()
    
    // MARK: - Action
    enum Action {
        case refresh
        
        // button
        case rankingButtonDidTap
        case settingButtonDidTap
        
        case calendarButtonDidTap
        case tomorrowButtonDidTap
        case yesterdayButtonDidTap
        
        case mealContainerDidTap(MealType)
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setDate(Date)
    }
    
    // MARK: - State
    struct State {
        var date: Date = Date()
    }
}

// MARK: - Mutate
extension HomeViewReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return .empty()
            
        case .rankingButtonDidTap:
            return .empty()
        case .settingButtonDidTap:
            return .empty()
            
        case .calendarButtonDidTap:
            return .empty()
        case .tomorrowButtonDidTap:
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentState.date) ?? Date()
            return Observable.just(Mutation.setDate(tomorrow))
        case .yesterdayButtonDidTap:
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentState.date) ?? Date()
            return Observable.just(Mutation.setDate(yesterday))
            
        case .mealContainerDidTap(let type):
            print(type)
            return .empty()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setDate(let date):
            newState.date = date
        }
        return newState
    }
}
