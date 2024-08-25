//
//  Event.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct EventView: View {
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
                    Text("All teams")
                    Text("About this event")
                }
            }
            .navigationTitle("Event")
        }
    }
}

#Preview {
    EventView(eventInfo: .preview)
}
