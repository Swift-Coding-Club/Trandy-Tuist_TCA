//
//  AddContactFeature.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import ComposableArchitecture

struct AddContactFeature: Reducer {
    
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action: Equatable {
        case cancelButtonTapped
        case delegate(Delegate)
        case saveButtonTapped
        case setName(String)
        
        enum  Delegate: Equatable {
            case saveContact(Contact)
        }
        
    }
    
    @Dependency(\.dismiss) var dismiss
    
     func reduce(into state: inout State, action: Action) -> Effect<Action> {
       switch action {
       case .cancelButtonTapped:
         return .run { _ in await self.dismiss() }

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
    



