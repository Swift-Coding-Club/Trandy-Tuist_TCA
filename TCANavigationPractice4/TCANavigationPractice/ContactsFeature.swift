//
//  ContactsFeature.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//
import Foundation
import ComposableArchitecture
import SwiftUI


struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

struct ContactsFeature: Reducer {
    struct State: Equatable {
        @PresentationState var destination: Destination.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    enum Action: Equatable {
        case addButtonTapped
        case destination(PresentationAction<Destination.Action>)
        case deleteButtonTapped(id: Contact.ID)
        
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    // 1-7. UUID dependency를 추가
    @Dependency(\.uuid) var uuid
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.destination = .addContact(
                          AddContactFeature.State(
//                            contact: Contact(id: UUID(), name: "")
                            contact: Contact(id: self.uuid(), name: "") // 1-8
                          )
                )
                return .none
            case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
                state.contacts.append(contact)
                return .none
                
            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.contacts.remove(id: id)
                return .none
                
            case .destination:
                    return .none
                
            case let .deleteButtonTapped(id: id):
                state.destination = .alert(.deleteConfirmation(id: id))
                      
                return .none
            }
        }
        .ifLet(\.$destination, action: /Action.destination) {
             Destination()
           }
    }
}
