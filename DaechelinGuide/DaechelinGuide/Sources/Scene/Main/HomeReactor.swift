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
    
    //test
    func fetchMenu() -> MenuResponse {
        return MenuResponse(
            date: "2024년 05월 03일 (금)",
            breakfast: "들깨계란죽 -감자햄볶음 나박김치 아몬드후레이크+우유 통영식꿀빵",
            lunch: "*브리오슈싸이버거 유부초밥/크래미 미소된장국 모듬야채피클 오렌지주스",
            dinner: nil
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .fetchMenu:
            return Observable.just(Mutation.setMenu(fetchMenu()))
            
        case .refresh:
            return Observable.just(Mutation.setRefreshing(false))
                .delay(.milliseconds(500), scheduler: MainScheduler.instance)
                .startWith(Mutation.setRefreshing(true))
                .concat(Observable.just(Mutation.setDate(Date())))
            
        case .calendarButtonDidTap:
            return .empty()
            
        case .tomorrowButtonDidTap:
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: currentState.date) ?? Date()
            return Observable.just(Mutation.setDate(tomorrow))
            
        case .yesterdayButtonDidTap:
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentState.date) ?? Date()
            return Observable.just(Mutation.setDate(yesterday))
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
