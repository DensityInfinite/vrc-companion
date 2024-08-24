//
//  ContentView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var state = StateController()
    
    var body: some View {
        TabView {
            UpcomingView()
                .tabItem {
                    Label("Upcoming", systemImage: "chevron.forward.2")
                }
                .environmentObject(state)
            
            EventView()
                .tabItem {
                    Label("Event", systemImage: "calendar")
                }
            
            WatchlistView()
                .tabItem {
                    Label("Watchlist", systemImage: "star")
                }
            
            TeamFullView(title: "My Team", teamID: state.userTeamInfo.id)
                .tabItem {
                    Label("My team", systemImage: "person")
                }
                .environmentObject(state)
            
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
