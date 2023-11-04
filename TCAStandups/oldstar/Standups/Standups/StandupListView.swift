//
//  StandupListView.swift
//  Standups
//
//  Created by Gordon Choi on 11/5/23.
//

import SwiftUI

struct StandupListView: View {
    var body: some View {
        List {
            
        }
        .navigationTitle("Daily Standups")
        .toolbar {
            ToolbarItem {
                Button("Add") { }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StandupListView()
    }
}
