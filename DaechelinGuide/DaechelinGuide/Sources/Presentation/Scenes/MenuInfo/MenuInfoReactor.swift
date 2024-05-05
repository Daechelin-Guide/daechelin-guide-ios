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
        case fetchComments
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setMenuDetail(MenuDetailResponse?)
        case setComments([String])
        case setRefreshing(Bool)
    }
    
    // MARK: - State
    struct State {
        var date: Date
        var type: MealType
        var menuDetail: MenuDetailResponse?
        var comments: [String]?
        var isRefreshing: Bool = false
    }
    
    init(date: Date, type: MealType) {
        self.initialState = State(date: date, type: type)
    }
}

// MARK: - Mutate
extension MenuInfoReactor {
    
    private func fetchMenuDetail() -> Observable<Mutation> {
        return MenuProvider.shared
            .getMenuDetail(
                currentState.date.formattingDate(format: "yyyyMMdd"),
                currentState.type
            )
            .flatMap { result -> Observable<Mutation> in
                switch result {
                case .success(let data):
                    return Observable.just(.setMenuDetail(data))
                case .failure(_):
                    return Observable.empty()
                }
            }
    }
    
    private func fetchComments() -> Observable<Mutation> {
        return RatingProvider.shared
            .getRating(currentState.menuDetail?.id ?? 0)
            .flatMap { result -> Observable<Mutation> in
                switch result {
                case .success(let data):
                    return Observable.just(.setComments(data))
                case .failure(_):
                    return Observable.empty()
                }
            }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .refresh:
            return Observable.concat([
                Observable.just(Mutation.setRefreshing(true)),
                fetchMenuDetail(),
                Observable.just(Mutation.setRefreshing(false))
            ])
            
        case .fetchMenuDetail:
            return fetchMenuDetail()
            
        case .fetchComments:
            return fetchComments()
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setMenuDetail(let menuDetail):
            newState.menuDetail = menuDetail
            
        case .setComments(let comments):
            newState.comments = comments
            
        case .setRefreshing(let isRefreshing):
            newState.isRefreshing = isRefreshing
        }
        return newState
    }
}
