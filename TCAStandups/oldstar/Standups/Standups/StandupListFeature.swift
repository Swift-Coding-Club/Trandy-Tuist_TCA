//
//  StandupListFeature.swift
//  Standups
//
//  Created by Gordon Choi on 11/5/23.
//

import Foundation

import ComposableArchitecture

struct StandupListFeature: Reducer {
    struct State {
        var standups: IdentifiedArrayOf<Standup> = []
    }
    
    enum Action {
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.standups.append(
                    Standup(
                        id: UUID(),
                        theme: .allCases.randomElement()!
                    )
                )
                
                return .none
            }
        }
    }
}
