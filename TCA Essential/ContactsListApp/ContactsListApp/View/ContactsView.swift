//
//  ContactsView.swift
//  ContactsListApp
//
//  Created by 염성훈 on 10/28/23.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
  let store: StoreOf<ContactsFeature>

  var body: some View {
    NavigationStack {
      WithViewStore(self.store, observe: \.contacts) { viewStore in
        List {
          ForEach(viewStore.state) { contact in
            Text(contact.name)
          }
        }
        .navigationTitle("Contacts")
        .toolbar {
          ToolbarItem {
            Button {
              viewStore.send(.addButtonTapped)
            } label: {
              Image(systemName: "plus")
            }
          }
        }
        ///TCA에서 제공하는 함수로 기본의 .sheet와는 다르다.
        .sheet(store: self.store.scope(state: \.$addContact,
                                       action: {
            .addContact($0)
        })) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
      }
    }
  }
}

struct ContactsView_Previews: PreviewProvider {
  static var previews: some View {
    ContactsView(
      store: Store(
        initialState: ContactsFeature.State(
          contacts: [
            Contact(id: UUID(), name: "Blob"),
            Contact(id: UUID(), name: "Blob Jr"),
            Contact(id: UUID(), name: "Blob Sr"),
          ]
        )
      ) {
        ContactsFeature()
      }
    )
  }
}
