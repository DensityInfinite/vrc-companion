//
//  MyTeam.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct TeamFullView: View {
    @EnvironmentObject var state: StateController
    @State private var statsSelection = 0
    var teamInfo: TeamInfoModel
    var teamRankings: RankingsModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Overview", content: {
                    TeamOverviewView(teamInfo: teamInfo, teamRankings: teamRankings)
                })
            }
            .navigationTitle("My Team")
        }
    }
}

#Preview {
    TeamFullView(teamInfo: .preview, teamRankings: .preview)
        .environmentObject(StateController())
}
