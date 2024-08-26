//
//  Watchlist.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI
import SwiftData

struct WatchlistView: View {
    @Environment(StateController.self) var state
    @Query var watchlist: [TeamInfoModel]

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        ForEach(watchlist) { team in
                            Text(team.number)
                        }
                    }
                }
                .navigationTitle("Watchlist")
                if watchlist.isEmpty {
                    VStack {
                        Image(systemName: "star")
                            .font(.title)
                            .imageScale(.large)
                            .foregroundStyle(.secondary)
                        Text("Your Watchlist is Empty")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("Watch teams for quick access to their statistics.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    WatchlistView()
        .environment(StateController())
}
