//
//  ContactsListAppApp.swift
//  ContactsListApp
//
//  Created by 염성훈 on 10/28/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct ContactsListAppApp: App {
    var body: some Scene {
        WindowGroup {
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
}
