//
//  CounterFeatureTests.swift
//  CounterFeatureTests
//
//  Created by Gordon Choi on 10/22/23.
//

import XCTest

import ComposableArchitecture

@MainActor
final class CounterFeatureTests: XCTestCase {
    func testCounter() async {
        let testStore = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await testStore.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await testStore.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
}
