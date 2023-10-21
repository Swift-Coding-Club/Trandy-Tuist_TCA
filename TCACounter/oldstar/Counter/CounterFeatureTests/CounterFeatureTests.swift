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
        
        // 이 테스트는 실패할 수 밖에 없습니다
        // 먼저 이 api에서 매번 다른 응답을 보내 줍니다
        // 인터넷 연결 관련된 이슈 때문에, 테스트를 한다 해도 의미가 크지 않습니다
        // mock 객체를 만드는 방법으로 해 볼 수 있을까요?
        await testStore.receive(.factResponse("???"), timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "???"
        }
    }
}
