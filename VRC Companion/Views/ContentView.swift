//
//  ContentView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            UpcomingView(matchlist: .preview)
                .tabItem {
                    Label("Upcoming", systemImage: "chevron.forward.2")
                }
            
            EventView()
                .tabItem {
                    Label("Event", systemImage: "calendar")
                }
            
            WatchlistView()
                .tabItem {
                    Label("Watchlist", systemImage: "star")
                }
            
            MyTeamView()
                .tabItem {
                    Label("My team", systemImage: "person")
                }
            LookupView()
                .tabItem {
                    Label("Lookup", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ContentView()
}
