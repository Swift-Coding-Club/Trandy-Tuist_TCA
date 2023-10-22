//
//  YourFirstFeatureApp.swift
//  YourFirstFeature
//
//  Created by 현수빈 on 10/22/23.
//
import ComposableArchitecture
import SwiftUI

@main
struct MyApp: App {
    // store은 어플리케이션에서 딱 한번 생성되어야 함 따라서 정적변수로 생성
  static let store = Store(initialState: CounterFeature.State()) {
    CounterFeature()
          ._printChanges() // 이 메서드를 사용하면 축소기에서 처리하는 모든 액션이 콘솔에 인쇄되고 액션을 처리한 후 상태가 어떻게 변했는지 인쇄됨. 변경되지 않은 경우 중첩 상태를 표시하지 않는 것, 변경되지 않은 요소를 컬렉션에 표시하지 않는 것 등이 포함됨
  }

  var body: some Scene {
    WindowGroup {
      CounterView(store: MyApp.store)
    }
  }
}
