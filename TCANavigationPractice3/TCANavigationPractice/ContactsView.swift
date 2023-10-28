//
//  ContactsView.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//
import SwiftUI
import ComposableArchitecture

// 1-3. store을 가지고 있는 contactsview를 생성
struct ContactsView: View {
  let store: StoreOf<ContactsFeature>

  var body: some View {
    NavigationStack {
      WithViewStore(self.store, observe: \.contacts) { viewStore in
        List {
          ForEach(viewStore.state) { contact in
              // 1-8
              HStack {
                  Text(contact.name)
                  Spacer()
                  Button {
                      viewStore.send(.deleteButtonTapped(id: contact.id))
                  } label: {
                      Image(systemName: "trash")
                          .foregroundColor(.red)
                  }
              }
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
      }
    }
      // 3-1. navigation을 흉내내는 코드, 기존 swiftUI에 추가적으로 store을 받음
      // store을 축소해서 sheet를 띄움, addContact state가 non nil일 때 addContactFeatre에 맞는 새로운 store이 도출됨
//    .sheet(
//         store: self.store.scope(
//           state: \.$addContact,
//           action: { .addContact($0) }
//         )
//       ) { addContactStore in
//         NavigationStack {
//           AddContactView(store: addContactStore)
//         }
//       }
//      // 1-7
//       .alert(
//             store: self.store.scope(
//               state: \.$alert,
//               action: { .alert($0) }
//             )
//           )
      // 1-16 destination으로 변경
    .sheet(
          store: self.store.scope(state: \.$destination, action: { .destination($0) }),
          state: /ContactsFeature.Destination.State.addContact,
          action: ContactsFeature.Destination.Action.addContact
        ) { addContactStore in
          NavigationStack {
            AddContactView(store: addContactStore)
          }
        }
        .alert(
          store: self.store.scope(state: \.$destination, action: { .destination($0) }),
          state: /ContactsFeature.Destination.State.alert,
          action: ContactsFeature.Destination.Action.alert
        )
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
