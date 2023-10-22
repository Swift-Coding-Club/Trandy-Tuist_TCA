//
//  YourFirstFeatureTests.swift
//  YourFirstFeatureTests
//
//  Created by 현수빈 on 10/22/23.
//

import XCTest
import ComposableArchitecture



@testable import YourFirstFeature
@MainActor
final class YourFirstFeatureTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Testing state Changes
    func testCounter() async { // Composable archtiecture의 test함수는 async이기에 async 표시
        
        // TestStore: easy to assert on how the behavior of your feature changes as actions are sent into the system.
        let store = TestStore(initialState: CounterFeature.State()) {
          CounterFeature()
        }

        // you must also describe exactly how the state changes after that action is sent
        await store.send(.incrementButtonTapped) {
             $0.count = 1
            // 여기서 +=1보다는 = 으로 절대적인 값을 쓰는 것을 추천!! 그래야 정확하게 체크 가능
           }
           await store.send(.decrementButtonTapped) {
             $0.count = 0
           }
      }
    
    // MARK: - Section 2: Testing effects
    func testTimer() async {
        let clock = TestClock()

        let store = TestStore(initialState: CounterFeature.State()) {
          CounterFeature()
        } withDependencies: {
          $0.continuousClock = clock
        }

        await store.send(.toggleTimerButtonTapped) {
          $0.isTimerRunning = true
        }
        // 1초를 기다리지 않으면 실패로 간주하기 때문에 2초정도 기다리고 받으라고 추가
//        await store.receive(.timerTick, timeout: .seconds(2)) {
//              $0.count = 1
//            }
        // 하지만, 실제로 1초 기다리면 테스트 오래 걸리니까 clock이라는 feature을 만들어서 controll해보자!!
        await clock.advance(by: .seconds(1))
        await store.receive(.timerTick) {
          $0.count = 1
        }
        // 타이머를 끄지 않으면 종료되지 않으므로 테스트 실패하기 때문에 꼭 멈춰줘야 함
        await store.send(.toggleTimerButtonTapped) {
          $0.isTimerRunning = false
        }
      }
    
    
    
    // MARK: - Section 3 : Testing network request
    /*
    func testNumberFact() async {
       let store = TestStore(initialState: CounterFeature.State()) {
         CounterFeature()
       }

       await store.send(.factButtonTapped) {
         $0.isLoading = true
       }
       await store.receive(.factResponse("???"), timeout: .seconds(1)) {
         $0.isLoading = false
         $0.fact = "???"
       }
       // ❌ A state change does not match expectation: …
       //
       //       CounterFeature.State(
       //         count: 0,
       //     −   fact: "???",
       //     +   fact: "0 is the atomic number of the theoretical element tetraneutron.",
       //         isLoading: false,
       //         isTimerRunning: false
       //       )
     }
    */
    
    // MARK: - Section 4: Controlling dependencies
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
          CounterFeature()
        } withDependencies: {
          $0.numberFact.fetch = { "\($0) is a good number." }
        }

        await store.send(.factButtonTapped) {
          $0.isLoading = true
        }
        await store.receive(.factResponse("0 is a good number.")) {
          $0.isLoading = false
          $0.fact = "0 is a good number."
        }
      }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
