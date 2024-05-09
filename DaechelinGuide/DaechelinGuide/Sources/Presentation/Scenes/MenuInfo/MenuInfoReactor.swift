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
        case setComments([RatingResponse]?)
        case setIsFetching
    }
    
    // MARK: - State
    struct State {
        var date: Date
        var type: MealType
        var menuDetail: MenuDetailResponse?
        var comments: [RatingResponse]?
        var isFetching: Bool = false
    }
    
    init(date: Date, type: MealType) {
        self.initialState = State(date: date, type: type)
    }
}

// MARK: - Mutate
extension MenuInfoReactor {
    
    private func fetchMenuDetail() -> Observable<Mutation> {
        MenuProvider.shared
            .getMenuDetail(
                currentState.date.formattingDate(format: "yyyyMMdd"),
                currentState.type
            )
            .flatMap { result -> Observable<Mutation> in
                switch result {
                case .success(let data):
                    return Observable.just(.setMenuDetail(data))
                case .failure(_):
                    return Observable.just(.setMenuDetail(nil))
                }
            }
    }
    
    private func fetchComments() -> Observable<Mutation> {
        guard let id = currentState.menuDetail?.id else { return .empty() }
        return RatingProvider.shared.getRating(id)
            .flatMap { result -> Observable<Mutation> in
                switch result {
                case .success(let data):
                    return Observable.just(.setComments(
                        data.reversed()
                            .filter { !($0.comment.isEmpty) }
                    ))
                case .failure(_):
                    return Observable.just(.setComments([]))
                }
            }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .refresh:
            return Observable.concat([
                fetchMenuDetail(),
                Observable.just(Mutation.setComments(nil))
            ])
            .flatMap { _ in
                Observable.concat([
                    Observable.just(Mutation.setComments(nil)),
                    Observable.just(Mutation.setIsFetching),
                    self.fetchComments()
                ])
            }
            
        case .fetchMenuDetail:
            return fetchMenuDetail()
            
        case .fetchComments:
            return fetchMenuDetail().flatMap { _ in
                self.fetchComments()
            }
        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
            
        case .setMenuDetail(let menuDetail):
            newState.menuDetail = menuDetail
            newState.isFetching = false
            
        case .setComments(let comments):
            newState.comments = comments
            newState.isFetching = false
            
        case .setIsFetching:
            newState.isFetching = true
        }
        return newState
    }
}
