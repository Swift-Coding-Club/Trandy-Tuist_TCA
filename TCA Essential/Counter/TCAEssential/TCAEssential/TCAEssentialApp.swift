//
//  TCAEssentialApp.swift
//  TCAEssential
//
//  Created by 염성훈 on 10/22/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAEssentialApp: App {
    var body: some Scene {
        WindowGroup {
            CounterView(store: Store(initialState: CounterFeature.State(), reducer: {
                CounterFeature()
            }))
        }
    }
}
