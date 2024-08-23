//
//  MyTeam.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct TeamFullView: View {
    @EnvironmentObject var state: StateController
    @State private var statsSelection: StatsTypes = .matches
    var title: String
    var teamInfo: TeamInfoModel
    var teamRankings: RankingsModel
    var matchlist: MatchlistModel
    
    enum StatsTypes {
        case matches, global, local
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Overview", content: {
                    TeamOverviewView(teamInfo: teamInfo, teamRankings: teamRankings)
                })
                
                Section("Details", content: {
                    Picker("Statistics Level", selection: $statsSelection) {
                        Text("Matches").tag(StatsTypes.matches)
                        Text("Global Stats").tag(StatsTypes.global)
                        Text("Local Stats").tag(StatsTypes.local)
                    }
                    .pickerStyle(.segmented)
                    .listRowSeparator(.hidden)
                    
                    switch statsSelection {
                    case .matches:
                        ForEach(matchlist.matches) {match in
                            NavigationLink(destination: {
                                MatchDetails(match: match).environmentObject(state)
                            }, label: {
                                DetailedMatchRow(team: teamInfo, match: match)
                            })
                        }
                    case .global:
                        Text("Global")
                    case .local:
                        Text("Local")
                    }
                })
            }
            .animation(.default, value: statsSelection)
            .navigationTitle(title)
        }
    }
}

#Preview {
    TeamFullView(title: "My Team", teamInfo: .preview, teamRankings: .preview, matchlist: .preview)
        .environmentObject(StateController())
}
