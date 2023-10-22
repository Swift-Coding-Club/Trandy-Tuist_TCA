//
//  CountFeature.swift
//  YourFirstFeature
//
//  Created by 현수빈 on 10/22/23.
//
// 참고: https://pointfreeco.github.io/swift-composable-architecture/main/tutorials/composablearchitecture/01-01-yourfirstfeature

import ComposableArchitecture
import SwiftUI

// MARK: - 1. section 1: Create a reducer
struct CounterFeature: Reducer {
    // create a State type that holds the state your feature needs to do its job, typically a struct.

  struct State {
    var count = 0
  }
//  Then you will create an Action type that holds all the actions the user can perform in the feature, typically an enum.
  enum Action {
    case decrementButtonTapped
    case incrementButtonTapped
  }

    // The reduce method takes State as an argument and it is marked as inout. This means you can make any mutations you want directly to the state. There is no need to make a copy of the state just to return it.
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .decrementButtonTapped:
      state.count -= 1
      return .none // 아무런 effect가 없음을 표시

    case .incrementButtonTapped:
      state.count += 1
      return .none
    }
  }
}


// MARK: - 2. Integrating with SwiftUI
// 2-1. Store: represent the runtime of the feature
// 2-2. ViewStore: represent the observation of the runtime

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
      }
    }
  }
}


struct CounterPreview: PreviewProvider {
  static var previews: some View {
    CounterView(
      store: Store(initialState: CounterFeature.State()) {
        CounterFeature() // 여기를 주석하면 view는 동일하지만 동작이 되지 않음, 즉 reducer만 바꾸면 여러가지 동작을 할 수 있게 된다는 것!!
      }
    )
  }
}
