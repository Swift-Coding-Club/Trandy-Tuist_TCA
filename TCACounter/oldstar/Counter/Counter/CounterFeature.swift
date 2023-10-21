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
        var isTimerRunning = false
    }
    
    enum Action: Equatable {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID { case timer }
    
    @Dependency(\.continuousClock) var clock
    
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
                await send(.factResponse(fact))
            } catch: { error, send in
                print(error)
            }
        case let .factResponse(fact):
            state.fact = fact
            state.isLoading = false
            return .none
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            
            if state.isTimerRunning {
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        case .timerTick:
            state.count += 1
            state.fact = nil
            return .none
        }
    }
}
