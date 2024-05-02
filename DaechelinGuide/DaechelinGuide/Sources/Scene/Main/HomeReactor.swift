//
//  HomeReactor.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import Foundation
import ReactorKit

final class HomeReactor: Reactor {
    
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
        
        case setRefreshing(Bool)
    }
    
    // MARK: - State
    struct State {
        var date: Date = Date()
        
        var isRefreshing: Bool = false
    }
}

// MARK: - Mutate
extension HomeReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            return Observable.just(Mutation.setRefreshing(false))
                .delay(.milliseconds(500), scheduler: MainScheduler.instance)
                .startWith(Mutation.setRefreshing(true))
                .concat(Observable.just(Mutation.setDate(Date())))
            
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
            
        case .setRefreshing(let isRefreshing):
            newState.isRefreshing = isRefreshing
        }
        return newState
    }
}
