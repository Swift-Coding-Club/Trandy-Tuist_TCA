//
//  YourFirstFeatureApp.swift
//  Your first feature
//
//  Created by 서원지 on 10/22/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct YourFirstFeatureApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            
            ContentView(store: YourFirstFeatureApp.store)
        }
    }
}
