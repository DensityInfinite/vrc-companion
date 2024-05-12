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
            Upcoming()
                .tabItem {
                    Label("Upcoming", systemImage: "chevron.forward.2")
                }
            
            Event()
                .tabItem {
                    Label("Event", systemImage: "calendar")
                }
            
            Watchlist()
                .tabItem {
                    Label("Watchlist", systemImage: "star")
                }
            
            MyTeam()
                .tabItem {
                    Label("My team", systemImage: "person.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
