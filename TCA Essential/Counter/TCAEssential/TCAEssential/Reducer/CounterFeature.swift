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
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factResponse(String)
        case timerTick
        case factButtonTapped
        case toggleTimerButtonTapped
    }
    
    enum CancelID { case timer }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .decrementButtonTapped:
            state.count -= 1
//            state.fact = nil
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
//            state.fact = nil
            return .none
            
        case .factButtonTapped:
//            state.fact = nil
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
            
        case .timerTick:
            state.count += 1
            state.fact = nil
            return .none
            
        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            if state.isTimerRunning {
                return .run { send in
                    while true {
                        //1초씩 이벤트를 주는 ㅂ아법
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                //효과 취소를 통해서 타이머 중지를 툴러서 타이머를 멈출수가 있다.
                return .cancel(id: CancelID.timer)
            }
        }
        
    }
}

extension CounterFeature.State: Equatable {
    
}
