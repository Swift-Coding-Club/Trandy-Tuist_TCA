//
//  Your_first_featureApp.swift
//  Your first feature
//
//  Created by 서원지 on 10/22/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct Your_first_featureApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView(store: Your_first_featureApp.store)
        }
    }
}
