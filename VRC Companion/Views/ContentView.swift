//
//  ContentView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    /// The shared global state, holds the single source of truth of the application.
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
            
            TeamFullView(title: "You", teamID: state.userTeamInfo.id)
                .tabItem {
                    Label("You", systemImage: "person")
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema([
            TeamInfoModel.self,
            LocationModel.self,
            IDInfoModel.self
        ])
        let container = try ModelContainer(for: schema, configurations: config)
        return ContentView()
            .environment(StateController())
            .modelContainer(container)
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}
