//
//  Event.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var state: StateController
    var eventInfo: EventInfoModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Skills") {
                    NavigationLink {
                        DemoView(title: "Event skills", titleStyle: .inline)
                    } label: {
                        Text("Event-level rankings")
                    }
                }
                
                Section("Divisions") {
                    ForEach(eventInfo.divisions) { division in
                        NavigationLink {
                            DemoView(title: division.name, titleStyle: .inline)
                        } label: {
                            Text(division.name.contains("Default") ? "Default" : division.name)
                        }
                    }
                }
                
                Section("About") {
                    Text("About this event")
                    NavigationLink {
                        TeamListView(teamList: .preview)
                            .environmentObject(state)
                    } label: {
                        Text("All teams")
                    }
                }
            }
            .navigationTitle("Event")
        }
    }
}

#Preview {
    EventView(eventInfo: .preview)
        .environmentObject(StateController())
}
