//
//  AddContactFeature.swift
//  ContactsListApp
//
//  Created by 염성훈 on 10/28/23.
//

import ComposableArchitecture

struct AddContactFeature: Reducer {
    
  struct State: Equatable {
    var contact: Contact ///Detail Info
  }
    
    enum Action: Equatable {
        case cancelButtonTapped
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        //Delegate를 설정함으로써 하위뷰에서 발생하는 모든 이벤트를 부모뷰로 보낼 수 있음.
        enum Delegate: Equatable {
//          case cancel
          case saveContact(Contact)
        }
      }
    
    @Dependency(\.dismiss) var dismiss
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .cancelButtonTapped:
            return .run { _ in await self.dismiss() } //dismiss는 비동기적이기 떄문에 Effect를 return하는게 맞다.
            
        case .delegate:
            return .none
            
        case .saveButtonTapped:
              return .run { [contact = state.contact] send in
                await send(.delegate(.saveContact(contact)))
                await self.dismiss()
              }
            
        case let .setName(name):
            state.contact.name = name
            return .none
        }
    }
}
