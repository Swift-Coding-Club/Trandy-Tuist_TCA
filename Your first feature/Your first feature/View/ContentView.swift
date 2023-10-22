//
//  ContentView.swift
//  Your first feature
//
//  Created by 서원지 on 10/22/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    //MARK: -  관찰자
    let store: StoreOf<CounterFeature>
    var body: some View {
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
            }
        }
    }
}

#Preview {
    ContentView(store: .init(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}

