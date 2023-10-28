//
//  ContactsFeature.swift
//  ContactsListApp
//
//  Created by 염성훈 on 10/28/23.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

struct ContactsFeature: Reducer {
    struct State: Equatable {
        @PresentationState var addContact: AddContactFeature.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action: Equatable {
        
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)  //PresentationAction은 하위 뷰의 모든 작업을 관찰할 수 있게 해준다.
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                // TODO: Handle action
                
                state.addContact = AddContactFeature.State(
                          contact: Contact(id: UUID(), name: "")
                        )
                return .none
                //부모뷰에서 cancle을 받아서 처리하는건 비효율적임
//            case .addContact(.presented(.delegate(.cancel))): //presentataionAction으로 구조를 잡으면 AddContatctFeature(이동할 뷰의 reduder)를 가져올 수 있음.
//                state.addContact = nil
//                return .none
            
            case .addContact(.presented(.delegate(.saveContact(let contact)))):
                state.contacts.append(contact)
//                state.addContact = nil
                return .none
                
            case .addContact:
                return .none
            }
        }
        
        .ifLet(\.$addContact, action: /Action.addContact) { //이 기능을 실행해야 자식의 reducer가 실행될떄, 상위의 reducer가 모든 엑션을 맏을 수 있다. 그리고 자식이 dismiss될떄, 같이 옵저버가 해제된다.
              AddContactFeature()
            }
    }
    
    
}
