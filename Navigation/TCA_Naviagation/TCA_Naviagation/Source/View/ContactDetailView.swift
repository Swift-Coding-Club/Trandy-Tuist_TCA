//
//  ContactDetailView.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            Form {
                
            }
            .navigationTitle(Text(viewStore.contact.name))
        }
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(
            store: Store(
                initialState: ContactDetailFeature.State(
                    contact: Contact(id: UUID(), name: "Blob")
                )
            ) {
                ContactDetailFeature()
            }
        )
    }
}
