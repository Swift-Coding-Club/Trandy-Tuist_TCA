//
//  CounterApp.swift
//  Counter
//
//  Created by Gordon Choi on 10/21/23.
//

import SwiftUI

import ComposableArchitecture

@main
struct CounterApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: CounterApp.store
            )
        }
    }
}
