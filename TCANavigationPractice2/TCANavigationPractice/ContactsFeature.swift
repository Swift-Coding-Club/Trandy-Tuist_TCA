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
//        @PresentationState var addContact: AddContactFeature.State?
//        // 1-2. PresentationState 추가
//        @PresentationState var alert: AlertState<Action.Alert>?
        // 2-2. Destination추가로 인해 위의 두개를 지우고 하나로 통일 가능
        @PresentationState var destination: Destination.State?
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    enum Action: Equatable {
        case addButtonTapped
//        case addContact(PresentationAction<AddContactFeature.Action>)
//        case alert(PresentationAction<Alert>)
        case destination(PresentationAction<Destination.Action>) // 2-8
        case deleteButtonTapped(id: Contact.ID) // 1-1. 새로운 action 추가
        
        enum Alert: Equatable {
            case confirmDeletion(id: Contact.ID)
        }
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
//                state.addContact = AddContactFeature.State(
//                    contact: Contact(id: UUID(), name: "")
//                )
                // 2-10. destination으로 변경
                state.destination = .addContact(
                          AddContactFeature.State(
                            contact: Contact(id: UUID(), name: "")
                          )
                )
                return .none
//            case let .addContact(.presented(.delegate(.saveContact(contact)))):
                // 2-11
            case let .destination(.presented(.addContact(.delegate(.saveContact(contact))))):
                state.contacts.append(contact)
                return .none
                
                // 2-12
            case let .destination(.presented(.alert(.confirmDeletion(id: id)))):
                state.contacts.remove(id: id)
                return .none
                
//            case .addContact:
//                return .none
                
            case .destination:
                    return .none
                
            case let .deleteButtonTapped(id: id):
//                state.alert = AlertState {
//                    TextState("Are you sure?")
//                } actions: {
//                    ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
//                        TextState("Delete")
//                    }
//                }
                state.destination = .alert(
                         AlertState {
                           TextState("Are you sure?")
                         } actions: {
                           ButtonState(role: .destructive, action: .confirmDeletion(id: id)) {
                             TextState("Delete")
                           }
                         }
                       )
                return .none
                // 1-6
//            case let .alert(.presented(.confirmDeletion(id: id))):
               
                
//            case .alert:
//                return .none
                
            }
        }
        // embed child reducer in parent domain
//        .ifLet(\.$addContact, action: /Action.addContact) {
//            AddContactFeature()
//        }
//        .ifLet(\.$alert, action: /Action.alert) // 1-5
        // 2-15
        .ifLet(\.$destination, action: /Action.destination) {
             Destination()
           }
    }
}
