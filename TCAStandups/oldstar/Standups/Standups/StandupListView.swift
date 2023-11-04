//
//  StandupListView.swift
//  Standups
//
//  Created by Gordon Choi on 11/5/23.
//

import SwiftUI

import ComposableArchitecture

struct StandupListView: View {
    let store: StoreOf<StandupListFeature>
    
    var body: some View {
        WithViewStore(store, observe: \.standups) { viewStore in
            List {
                ForEach(viewStore.state) { standup in
                    CardView(standup: standup)
                        .listRowBackground(standup.theme.mainColor)
                }
            }
        }
        .navigationTitle("Daily Standups")
        .toolbar {
            ToolbarItem {
                Button("Add") {
                    store.send(.addButtonTapped)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StandupListView(
            store: Store(initialState: StandupListFeature.State()) {
                StandupListFeature()
            }
        )
    }
}
