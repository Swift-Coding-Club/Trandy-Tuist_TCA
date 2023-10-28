//
//  ContactDetailFeature.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//

import Foundation
import ComposableArchitecture

// 1. contactDetail 추가
struct ContactDetailFeature: Reducer {
  struct State: Equatable {
    let contact: Contact
  }
  enum Action: Equatable {
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      }
    }
  }
}
