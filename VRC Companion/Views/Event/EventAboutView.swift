//
//  EventAboutView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/8/2024.
//

import SwiftUI

struct EventAboutView: View {
    var eventInfo: EventInfoModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    SimpleRow(label: "Event Status", details: eventInfo.ongoing ? "In Progress" : "Ended")
                    SimpleRow(label: "Award Status", details: eventInfo.awardsFinalized ? "Finalised" : "Judging")
                }
                
                Section {
                    SimpleRow(label: "Event Level", details: eventInfo.level)
                    SimpleRow(label: "Season", details: eventInfo.season.name)
                }
            }
            .padding(.top, -30)
            .navigationTitle("About this Event")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EventAboutView(eventInfo: .preview)
}
