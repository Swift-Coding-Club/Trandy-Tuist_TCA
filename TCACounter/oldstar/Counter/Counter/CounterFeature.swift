//
//  CounterFeature.swift
//  Counter
//
//  Created by Gordon Choi on 10/21/23.
//

import Foundation

import ComposableArchitecture

struct CounterFeature: Reducer {
    struct State: Equatable {
        var count = 0
        var fact: String?
        var isLoading = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
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
            
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(state.count)")!)
            // async도 reduce 함수에서 지원을 안 하네요?
            // 에러 핸들링은 안 돼 있습니다
            
            state.fact = String(decoding: data, as: UTF8.self)
            
            return .none
        }
    }
}
