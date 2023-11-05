//
//  ContactsFeature.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import Foundation
import ComposableArchitecture


struct ContactFeature: Reducer {
    
    struct State: Equatable {
//        @PresentationState var addContact: AddContactFeature.State?
//        @PresentationState var alert: AlertState<Action.Alert>?
        var contacts: IdentifiedArrayOf<Contact> = []
        @PresentationState var destination: Destination.State?
        var path = StackState<ContactDetailFeature.State>()
    }
    
    enum Action: Equatable {
        case addButtonTapped
//        case addContact(PresentationAction<AddContactFeature.Action>)
        case deleteButtonTapped(id: Contact.ID)
        case destination(PresentationAction<Destination.Action>)
//        case alert(PresentationAction<Alert>)
        case path(StackAction<ContactDetailFeature.State, ContactDetailFeature.Action>)
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    @Dependency(\.uuid) var uuid
    var body: some ReducerOf<Self> {
       Reduce { state, action in
         switch action {
         case .addButtonTapped:
           state.destination = .addContact(
             AddContactFeature.State(
                contact: Contact(id: self.uuid(), name: "")
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
             
         case .path:
             return .none
         }
       }
       .ifLet(\.$destination, action: /Action.destination) {
           Destination()
       }
       .forEach(\.path, action: /Action.path) {
           ContactDetailFeature()
       }
    }
}
