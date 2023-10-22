//
//  CounterFeature.swift
//  Your first feature
//
//  Created by 서원지 on 10/22/23.
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
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID { case timer }
    
    //MARK: - 시간 기반 비동기성에 대한 종속성을 제어하기 위한 약간의 사전 작업을 통해 이제 결정론적으로 즉시 통과하는 매우 간단한 테스트를 작성할 수 있습니다.
    @Dependency(\.continuousClock) var clock
    
    @Dependency(\.numberFact) var numberFact
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.fact = nil
            state.count -= 1
            //MARK: -  아무런  effect가 없을 표시
            return .none
            
            
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
            
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true
            return .run { [count = state.count] send in
                try await send(.factResponse(self.numberFact.fetch(count)))
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
                // stop을 누를 때는 멈춰야 하기 때문에 추가한 코드, We can mark any effect as cancellable
                // 그런데  combine cancellable을 써도 되지 않을까 라는 생각
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

//MARK: -  withViewStore을 위해 추가
extension CounterFeature.State: Equatable {}

//MARK: - test에서 receive를 쓰기 위해 만족
extension CounterFeature.Action: Equatable {}


