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
    var testStore: TestStore<CounterFeature.State, CounterFeature.Action>!
    let clock = TestClock()
    
    override func setUpWithError() throws {
        testStore = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: { values in
            values.continuousClock = clock
            values.numberFact.fetch = { "\($0) is a good number." }
        }
        
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        testStore = nil
        
        try super.tearDownWithError()
    }
    
    func testCounter() async {
        await testStore.send(.incrementButtonTapped) {
            $0.count = 1
        }
        
        await testStore.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
    
    func testTimer() async {
        await testStore.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        
        await clock.advance(by: .seconds(1))
        await testStore.receive(.timerTick) {
            $0.count = 1
        }
        
        await testStore.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        await testStore.send(.factButtonTapped) {
            $0.isLoading = true
        }
        
        await testStore.receive(.factResponse("0 is a good number.")) {
            $0.isLoading = false
            $0.fact = "0 is a good number."
        }
    }
}
