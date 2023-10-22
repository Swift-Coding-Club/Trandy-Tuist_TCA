//
//  ContentView.swift
//  Your first feature
//
//  Created by 서원지 on 10/22/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    //MARK:  store: feature의 runtime을 represent, action을 처리하고 effect를 실행하고 data를 줄 수 있음
    
    let store: StoreOf<CounterFeature>
    var body: some View {
        // store을 바로 접근 못하기 때문에 withViewStore로 감싸서 접근, 이 때 state가 equtable해야 함
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
            }
            
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
                
                Button(viewStore.isTimerRunning ? "Stop timer" : "Start timer") {
                    viewStore.send(.toggleTimerButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(10)
            }
            
            Button("Fact"){
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
        }
    }
}

#Preview {
    ContentView(store: .init(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}

