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
        
    }
    
    // MARK: - Mutation
    enum Mutation {
        
    }
    
    // MARK: - State
    struct State {
        
    }
}

// MARK: - Mutate
extension RankingReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//
//        }
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
