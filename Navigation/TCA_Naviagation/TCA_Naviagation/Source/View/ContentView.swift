//
//  ContentView.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import SwiftUI
import ComposableArchitecture


struct ContentView: View {
    let store: StoreOf<ContactFeature>
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) }))  {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                
                List{
                    ForEach(viewStore.state) { contact in
                        NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
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
                        .buttonStyle(.borderless)
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
            .sheet(
                  store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                  state: /ContactFeature.Destination.State.addContact,
                  action: ContactFeature.Destination.Action.addContact
                ) { addContactStore in
                  NavigationStack {
                    AddContactView(store: addContactStore)
                  }
                }
//            .sheet(store: self.store.scope(state: \.$addContact, action: {.addContact($0)})) { addContactStore in
//                AddContactView(store: addContactStore)
//            }
//            .alert(store: self.store.scope(state: \.$alert, action: {.alert($0)}))
            
                .alert(
                      store: self.store.scope(state: \.$destination, action: { .destination($0) }),
                      state: /ContactFeature.Destination.State.alert,
                      action: ContactFeature.Destination.Action.alert
                    )
        } destination: { store in
            ContactDetailView(store: store)
        }
    }
}

#Preview {
    ContentView(store: Store(initialState: ContactFeature.State(contacts: [
        Contact(id: UUID(), name: "Blob"),
        Contact(id: UUID(), name: "Blob Jr"),
        Contact(id: UUID(),name: "Blob JD")
    ]), reducer: {
        ContactFeature()
    }))
}
