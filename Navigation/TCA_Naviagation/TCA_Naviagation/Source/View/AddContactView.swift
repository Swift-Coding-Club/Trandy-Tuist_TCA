//
//  AddContactView.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
    let store: StoreOf<AddContactFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0}) {  viewStore in
            Form {
                TextField("Name", text: viewStore.binding(get: \.contact.name, send: {.setName($0)}))
                
                Button("Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("cancel") {
                        viewStore.send(.cancelButtonTapped)
                    }
                }
            }
        }
    }
}

#Preview {
    AddContactView(store: Store(initialState: AddContactFeature.State(contact: Contact(id: UUID(), name: "blob")), reducer: {
        AddContactFeature()
    }))
}
