//
//  CounterFeature.swift
//  TCAEssential
//
//  Created by 염성훈 on 10/22/23.
//

import Foundation
import ComposableArchitecture

struct CounterFeature: Reducer {
    struct State {
       var count = 0
     }

     enum Action {
       case decrementButtonTapped
       case incrementButtonTapped
     }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
          state.count -= 1
          return .none

        case .incrementButtonTapped:
          state.count += 1
          return .none
        }
      }
}

extension CounterFeature.State: Equatable {
    
}
