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
        var fact: String?
        var isLoading = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factResponse(String)
        case factButtonTapped
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
            
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true
            
            return .run { [count = state.count] send in
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                let fact = String(decoding: data, as: UTF8.self)
                ///가져온 fact의 값을 state.fact = fact로 바로 변경할 수 없음.
                ///reduce함수의 stae인자가 inout이기 떄문에 .run이라는 함수안에서 state가 변경되면 원자성을 해치기 때문임.
                ///그래서 받아온 factRsponse를 await aync를 사용해서 다시 action으로 보내줘야한ㄷ.
                await send(.factResponse(fact))
            }
        case let .factResponse(fact):
            state.fact = fact
            state.isLoading = false
            return .none
        }
        
    }
}

extension CounterFeature.State: Equatable {
    
}
