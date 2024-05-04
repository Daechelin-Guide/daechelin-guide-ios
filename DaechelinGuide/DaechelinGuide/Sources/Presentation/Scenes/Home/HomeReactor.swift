//
//  HomeReactor.swift
//  DaechelinGuide
//
//  Created by 이민규 on 4/30/24.
//

import UIKit
import ReactorKit

final class HomeReactor: Reactor {
    
    // MARK: - Properties
    var initialState: State = State()
    
    // MARK: - Action
    enum Action {
        case refresh
        case fetchMenu
        
        // button
        case calendarButtonDidTap
        case tomorrowButtonDidTap
        case yesterdayButtonDidTap
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setDate(Date)
        case setMenu(MenuResponse)
        case setRefreshing(Bool)
    }
    
    // MARK: - State
    struct State {
        var date: Date = Date()
        var menu: MenuResponse?
        var isRefreshing: Bool = false
    }
}

// MARK: - Mutate
extension HomeReactor {
    
    // MARK: - Mutate
    private func fetchMenuForCurrentDate(date: Date? = nil) -> Observable<Mutation> {
        let targetDate = date ?? currentState.date
        return MenuProvider.shared
            .getMenu(targetDate.formattingDate(format: "yyyyMMdd"))
            .flatMap { result -> Observable<Mutation> in
                switch result {
                case .success(let data):
                    return Observable.just(.setMenu(data))
                case .failure(_):
                    return Observable.empty()
                }
            }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .fetchMenu:
            return fetchMenuForCurrentDate()
            
        case .refresh:
            return Observable.just(Mutation.setRefreshing(false))
                .delay(.milliseconds(500), scheduler: MainScheduler.instance)
                .startWith(Mutation.setRefreshing(true))
                .concat(Observable.just(Mutation.setDate(Date())))
                .concat(fetchMenuForCurrentDate())
            
        case .calendarButtonDidTap:
            return .empty()
            
        case .tomorrowButtonDidTap:
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentState.date) ?? Date()
            return Observable.just(Mutation.setDate(tomorrow))
                .concat(fetchMenuForCurrentDate())
            
        case .yesterdayButtonDidTap:
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentState.date) ?? Date()
            return Observable.just(Mutation.setDate(yesterday))
                .concat(fetchMenuForCurrentDate())
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setDate(let date):
            newState.date = date
            
        case .setMenu(let menu):
            newState.menu = menu
            
        case .setRefreshing(let isRefreshing):
            newState.isRefreshing = isRefreshing
        }
        return newState
    }
}
