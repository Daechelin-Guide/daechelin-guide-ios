//
//  MenuInfoReactor.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import Foundation
import ReactorKit

final class MenuInfoReactor: Reactor {
    
    // MARK: - Properties
    var initialState: State
    
    // MARK: - Action
    enum Action {
        case refresh
        case fetchMenuDetail
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setMenuDetail(MenuDetailResponse)
        case setRefreshing(Bool)
    }
    
    // MARK: - State
    struct State {
        var date: Date
        var type: MealType
        var menuDetail: MenuDetailResponse?
        var isRefreshing: Bool = false
    }
    
    init(date: Date, type: MealType) {
        self.initialState = State(date: date, type: type)
    }
}

// MARK: - Mutate
extension MenuInfoReactor {
    
    //test
    func fetchMenuDetail() -> MenuDetailResponse {
        return MenuDetailResponse(
            id: 99,
            menu: "*브리오슈싸이버거 유부초밥/크래미 미소된장국 모듬야채피클 오렌지주스",
            date: "2024년 05월 03일 (금)",
            cal: "796.3 Kcal",
            totalScore: 2.6,
            nutrients: "탄수화물(g) : 74.2, 단백질(g) : 39.0, 지방(g) : 38.1, 비타민A(R.E) : 48.2, 티아민(mg) : 0.4, 리보플라빈(mg) : 0.4, 비타민C(mg) : 120.7, 칼슘(mg) : 859.6, 철분(mg) : 7.9",
            mealType: .TYPE_LUNCH
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .refresh:
            return Observable.just(Mutation.setRefreshing(false))
                .delay(.milliseconds(500), scheduler: MainScheduler.instance)
                .startWith(Mutation.setRefreshing(true))
                .concat(Observable.just(Mutation.setMenuDetail(fetchMenuDetail())))
            
        case .fetchMenuDetail:
            return Observable.just(Mutation.setMenuDetail(fetchMenuDetail()))
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setMenuDetail(let menuDetail):
            newState.menuDetail = menuDetail
            
        case .setRefreshing(let isRefreshing):
            newState.isRefreshing = isRefreshing
        }
        return newState
    }
}
