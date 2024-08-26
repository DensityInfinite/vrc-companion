//
//  Watchlist.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct WatchlistView: View {
    @Environment(StateController.self) var state
    var body: some View {
        NavigationSplitView {
            List {
                Section("Teams") {
                    Text("Team Identifier")
                }
            }
            .navigationTitle("Watchlist")
        } detail: {
            Text("Select one to view details.")
        }
    }
}

#Preview {
    WatchlistView()
        .environment(StateController())
}
