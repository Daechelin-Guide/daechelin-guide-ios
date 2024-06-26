//
//  SettingReactor.swift
//  DaechelinGuide
//
//  Created by 이민규 on 5/2/24.
//

import Foundation
import ReactorKit

final class SettingReactor: Reactor {
    
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
extension SettingReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    // MARK: - Reduce
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
