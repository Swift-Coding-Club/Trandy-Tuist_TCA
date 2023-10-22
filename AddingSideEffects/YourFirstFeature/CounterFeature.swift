//
//  CountFeature.swift
//  YourFirstFeature
//
//  Created by 현수빈 on 10/22/23.
//
// 참고: https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/composablearchitecture/01-01-yourfirstfeature

import ComposableArchitecture
import SwiftUI

struct CounterFeature: Reducer {
    // create a State type that holds the state your feature needs to do its job, typically a struct.
    
    struct State {
        var count = 0
        var fact: String?
        var isLoading = false
        var isTimerRunning = false
    }
    //  Then you will create an Action type that holds all the actions the user can perform in the feature, typically an enum.
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case toggleTimerButtonTapped
        case timerTick
    }
    
    enum CancelID { case timer }
    
    // The reduce method takes State as an argument and it is marked as inout. This means you can make any mutations you want directly to the state. There is no need to make a copy of the state just to return it.
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none // 아무런 effect가 없음을 표시
            
        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
            
        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true
            // This provides you with an asynchronous context to perform any kind of work you want, as well as a handle (send) for sending actions back into the system.
            return .run { [count = state.count] send in
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                let fact = String(decoding: data, as: UTF8.self)
                // state.fact = fact <- However, it is not possible to then mutate the state.fact in the effect after fetching the data from the network. This is strictly enforced by the compiler since sendable closures cannot capture inout state. This is showing how the library chooses to separate the nice, simple and pure state mutations that reducers perform from the messy, complex effects.
                await send(.factResponse(fact))
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
                .cancellable(id: CancelID.timer) // stop을 누를 때는 멈춰야 하기 때문에 추가한 코드, We can mark any effect as cancellable
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



extension CounterFeature.State: Equatable {}

struct CounterView: View {
    // store: feature의 runtime을 represent, action을 처리하고 effect를 실행하고 data를 줄 수 있음
    // let로 선언해도 괜찮음!!
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        // store을 바로 접근 못하기 때문에 withViewStore로 감싸서 접근, 이 때 state가 equtable해야 함
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    Button("-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                }
                // MARK: - section 1: fact 버튼 추가
                Button("Fact") {
                    viewStore.send(.factButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
                
                if viewStore.isLoading {
                    ProgressView()
                } else if let fact = viewStore.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                
                // MARK: - section 3: timer 추가
                Button(viewStore.isTimerRunning ? "Stop timer" : "Start timer") {
                    viewStore.send(.toggleTimerButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
}


struct CounterPreview: PreviewProvider {
    static var previews: some View {
        CounterView(
            store: Store(initialState: CounterFeature.State()) {
                CounterFeature()
            }
        )
    }
}
