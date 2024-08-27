//
//  ContentView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct ContentView: View {
    @State var state = StateController()
    
    var body: some View {
        TabView {
            UpcomingView()
                .tabItem {
                    Label("Upcoming", systemImage: "chevron.forward.2")
                }
                .environment(state)
            
            EventView()
                .tabItem {
                    Label("Event", systemImage: "calendar")
                }
                .environment(state)

            WatchlistView()
                .tabItem {
                    Label("Watchlist", systemImage: "star")
                }
                .environment(state)
            
            TeamFullView(title: "My team", teamID: state.userTeamInfo.id)
                .tabItem {
                    Label("My team", systemImage: "person")
                }
                .environment(state)
            
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
