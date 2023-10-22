//
//  CounterView.swift
//  TCAEssential
//
//  Created by 염성훈 on 10/22/23.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
  let store: StoreOf<CounterFeature>

    var body: some View {
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
            }
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
        CounterFeature()
    }))
}
