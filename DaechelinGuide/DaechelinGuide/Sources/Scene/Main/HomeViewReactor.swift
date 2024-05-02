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
        case calendarButtonDidTap
        case tomorrowButtonDidTap
        case yesterdayButtonDidTap
        case rankingButtonDidTap
        case settingButtonDidTap
    }
    
    // MARK: - Mutation
    enum Mutation {
        
    }
    
    // MARK: - State
    struct State {
        var date: Date = Date()
    }
}
