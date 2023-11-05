//
//  TCA_NaviagationTests.swift
//  TCA_NaviagationTests
//
//  Created by 서원지 on 11/5/23.
//

import XCTest
import ComposableArchitecture

@testable import TCA_Naviagation

@MainActor
final class TCA_NaviagationTests: XCTestCase {

    func testAddFlow() async {
        let store = TestStore(initialState: ContactFeature.State()) {
            ContactFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(
                    contact: Contact(id: UUID(0), name: "")
                    
                )
            )
        }
        
        await store.send(.destination(.presented(.addContact(.setName("Blob Jr."))))) {
            $0.$destination[case: /ContactFeature.Destination.State.addContact]?.contact.name = "Blob Jr."
        }
        
        await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
        
        await store.receive(
             .destination(
               .presented(.addContact(.delegate(.saveContact(Contact(id: UUID(0), name: "Blob Jr.")))))
             )
           ) {
             $0.contacts = [
               Contact(id: UUID(0), name: "Blob Jr.")
             ]
           }
           await store.receive(.destination(.dismiss)) {
             $0.destination = nil
           }
    }
    
    func testAddFlow_NonExhaustive() async {
        let store = TestStore(initialState: ContactFeature.State()) {
          ContactFeature()
        } withDependencies: {
          $0.uuid = .incrementing
        }
        store.exhaustivity = .off

        await store.send(.addButtonTapped)
        await store.send(.destination(.presented(.addContact(.setName("Blob Jr.")))))
        await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
        await store.skipReceivedActions()
        await store.assert {
          $0.contacts = [
            Contact(id: UUID(0), name: "Blob Jr.")
          ]
          $0.destination = nil
        }
      }
    
    func testDeleteContact() async {
        let store = TestStore(
          initialState: ContactFeature.State(
            contacts: [
              Contact(id: UUID(0), name: "Blob"),
              Contact(id: UUID(1), name: "Blob Jr."),
            ]
          )
        ) {
          ContactFeature()
        }

        await store.send(.deleteButtonTapped(id: UUID(1))) {
          $0.destination = .alert(
            AlertState {
              TextState("Are you sure?")
            } actions: {
              ButtonState(role: .destructive, action: .confirmDeletion(id: UUID(1))) {
                TextState("Delete")
              }
            }
          )
        }
      }
}