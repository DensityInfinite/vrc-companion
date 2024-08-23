//
//  MatchDetails.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 23/2/2024.
//

import SwiftUI

struct MatchDetails: View {
    @EnvironmentObject var state: StateController
    var match: MatchModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    AtAGlanceView(match: match)
                        .environmentObject(state)
                        .padding(.top, -8)
                        .padding(.bottom, -8)
                }
                
                Section {
                    BannerView(match: match)
                        .environmentObject(state)
                }
                .listSectionSpacing(.compact)
                
                Section("Opponents - \(match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)!.color.capitalized) Alliance") {
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)!.teams[0])
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)!.teams[1])
                }
                
                Section("Your Alliance") {
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeamInfo.id, side: .team)!.teams[0])
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeamInfo.id, side: .team)!.teams[1])
                }
            }
            .navigationTitle(match.name)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, -30)
        }
    }
}

#Preview {
    MatchDetails(match: .preview)
        .environmentObject(StateController())
}
