//
//  Extension+ContactFeature.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import Foundation
import ComposableArchitecture

extension ContactFeature {
  struct Destination: Reducer {
    enum State: Equatable {
      case addContact(AddContactFeature.State)
      case alert(AlertState<ContactFeature.Action.Alert>)
    }
    enum Action: Equatable {
      case addContact(AddContactFeature.Action)
      case alert(ContactFeature.Action.Alert)
    }
    var body: some ReducerOf<Self> {
      Scope(state: /State.addContact, action: /Action.addContact) {
        AddContactFeature()
      }
    }
  }
}

extension AlertState where Action == ContactFeature.Action.Alert {
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
