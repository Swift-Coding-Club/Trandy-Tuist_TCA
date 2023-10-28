//
//  TCANavigationPracticeApp.swift
//  TCANavigationPractice
//
//  Created by 현수빈 on 10/28/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCANavigationPracticeApp: App {
    var body: some Scene {
        let store = Store(
            initialState: ContactsFeature.State(
              contacts: [
                Contact(id: UUID(), name: "Blob"),
                Contact(id: UUID(), name: "Blob Jr"),
                Contact(id: UUID(), name: "Blob Sr"),
              ]
            )
        ) {
            ContactsFeature()
                ._printChanges()
        }
        
        WindowGroup {
            ContactsView(store: store)
        }
    }
}
