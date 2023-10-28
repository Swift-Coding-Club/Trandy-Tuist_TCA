//
//  Alert+.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//

import Foundation
import ComposableArchitecture

// 3-7. 3-6처럼 하면 boilerplat가 많으니까 이렇게 하자!
extension AlertState where Action == ContactsFeature.Action.Alert {
  static func deleteConfirmation(id: UUID) -> Self {
    Self {
      TextState("Are you sure?")
    } actions: {
      ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
        TextState("Delete")
      }
    }
  }
}
