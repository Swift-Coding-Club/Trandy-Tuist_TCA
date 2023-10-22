//
//  Your_first_featureTests.swift
//  Your first featureTests
//
//  Created by 서원지 on 10/22/23.
//

import XCTest
import ComposableArchitecture

@testable import Your_first_featureUITests

@MainActor
final class CounterFeatureTests: XCTestCase {
  func testCounter() async {
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    }

      await store.send(.incrementButtonTapped) {
          $0.count = 1
      }
      await store.send(.decrementButtonTapped) {
          $0.count = 0
      }
  }
}
