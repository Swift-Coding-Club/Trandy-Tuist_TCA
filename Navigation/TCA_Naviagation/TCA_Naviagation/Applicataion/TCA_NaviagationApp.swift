//
//  TCA_NaviagationApp.swift
//  TCA_Naviagation
//
//  Created by 서원지 on 11/5/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_NaviagationApp: App {
    static let store = Store(initialState: ContactFeature.State()) {
        ContactFeature()
            ._printChanges()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(store: TCA_NaviagationApp.store)
        }
    }
}
