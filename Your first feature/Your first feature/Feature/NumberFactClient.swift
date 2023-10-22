//
//  NumberFactClient.swift
//  YourFirstFeature
//
//  Created by 서원지 on 10/22/23.
//

import ComposableArchitecture
import Foundation

// 1. 의존성을 제어하기 위해 인터페이스를 모델링
// 무조건 인터페이스가 protocol일 필요는 없음. 따라서 struct으로 생성
struct NumberFactClient{
    var fetch: (Int) async throws -> String
}

// 2. dependency key를 등록하기 위해 DependencyKey, DependencyValue를 구현

extension NumberFactClient: DependencyKey {
    // liveValue를 구현해야 함
    // value used when your feature is run in simulators and devices, and it’s the place where it is appropriate to make live network requests.
  static let liveValue = Self(
    fetch: { number in
      let (data, _) = try await URLSession.shared
            .data(from: URL(string: "\(API.factURL)\(number)")!)
      return String(decoding: data, as: UTF8.self)
    }
  )
}


extension DependencyValues {
  var numberFact: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}
