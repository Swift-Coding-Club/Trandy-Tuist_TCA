//
//  ContactsFeature.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//
import Foundation
import ComposableArchitecture
import SwiftUI

// 1. contacts Feature을 추가

// 1-1. 보여줄 contact를 구현
// test를 하기 위해 equatable, identifiable 추가
struct Contact: Equatable, Identifiable {
  let id: UUID
  var name: String
}

// 1-2. contactsView에서 할 일을 정의(reducer)
struct ContactsFeature: Reducer {
  struct State: Equatable {
      // 2-1. navigation을 하기 위해 추가
      // features' state를 integrate하기 위해 PresentationState 변수를 추가, optional을 저장(addContact feature가 presenteh되지 않으면 nil)
      @PresentationState var addContact: AddContactFeature.State?
    var contacts: IdentifiedArrayOf<Contact> = []
  }
  enum Action: Equatable {
    case addButtonTapped
      // 2-2. contact을 추가하는 action을 추가
    case addContact(PresentationAction<AddContactFeature.Action>)
    
      
  }
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .addButtonTapped:
          state.addContact = AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                  )
        return .none
          // 부모 feature은 child feature의 action을 들을 수 있고 additional logic을 처리할 수 있음
          // 2-7. addContact화면에서 cancel을 누를 때의 액션
//      case .addContact(.presented(.cancelButtonTapped)):
          // 4-4. delegate를 받는 걸로 변경
//      case .addContact(.presented(.delegate(.cancel))):
//              state.addContact = nil
//              return .none
          // 2-8. addContact에서 save 버튼을 누를 떄의 액션
//      case .addContact(.presented(.saveButtonTapped)):
      case let .addContact(.presented(.delegate(.saveContact(contact)))):
//             guard let contact = state.addContact?.contact
//             else { return .none }
             state.contacts.append(contact)
//             state.addContact = nil
             return .none
        
      case .addContact:
          return .none
      }
    }
      // 2-3. reducer를 integrate하기 위해 추가
      // 하위 작업이 들어올 때 child reducer를 실행하는 새로운 reducer가 생성되면 모든 작업에 대해 parent reducer를 실행
    .ifLet(\.$addContact, action: /Action.addContact) {
         AddContactFeature()
       }
  }
}
