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
        case didViewScroll(CGFloat)
        case notificationButtonDidTap
    }
    
    // MARK: - Mutation
    enum Mutation {
        case setTopBarBlurAppearance(Bool)
    }
    
    // MARK: - State
    struct State {
        var topBarBlurAppearance: Bool = false
    }
}
