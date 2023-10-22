//
//  ContentView.swift
//  YourFirstFeature
//
//  Created by 현수빈 on 10/22/23.
//
import ComposableArchitecture
import Foundation

// MARK: - Section 4: Controlling dependencies
// For these reasons, and more, it is highly encouraged for you to control you dependency on external systems (see Dependencies for more information). The Composable Architecture comes with a complete set of tools for controlling and propagating dependencies throughout an application.

// 1. 의존성을 제어하기 위해 인터페이스를 모델링
// 무조건 인터페이스가 protocol일 필요는 없음. 따라서 struct으로 생성
struct NumberFactClient {
  var fetch: (Int) async throws -> String
}

// 2. dependency key를 등록하기 위해 DependencyKey, DependencyValue를 구현
extension NumberFactClient: DependencyKey {
    // liveValue를 구현해야 함
    // value used when your feature is run in simulators and devices, and it’s the place where it is appropriate to make live network requests.
  static let liveValue = Self(
    fetch: { number in
      let (data, _) = try await URLSession.shared
        .data(from: URL(string: "http://numbersapi.com/\(number)")!)
      return String(decoding: data, as: UTF8.self)
    }
  )
}
// @Dependency(\.numberFact) in the reducer를 위해 추가
extension DependencyValues {
  var numberFact: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}
