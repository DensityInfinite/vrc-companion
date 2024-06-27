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
                
                Section("Opponents - \(match.allianceForTeam(id: state.userTeam.id, side: .opposition)!.color.capitalized) Alliance") {
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeam.id, side: .opposition)!.teams[0])
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeam.id, side: .opposition)!.teams[1])
                }
                
                Section("Your Alliance") {
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeam.id, side: .team)!.teams[0])
                    SmallTeamRow(team: match.allianceForTeam(id: state.userTeam.id, side: .team)!.teams[1])
                }
            }
            .navigationTitle(match.name)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, -18)
        }
    }
}

#Preview {
    MatchDetails(match: .preview)
        .environmentObject(StateController())
}
