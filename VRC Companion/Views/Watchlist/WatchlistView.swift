//
//  Watchlist.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct WatchlistView: View {
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
}
