//
//  AllianceTile.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct AllianceTileView: View {
    @EnvironmentObject var state: StateController
    @State private var topTeamRanking = APIModel()
    @State private var bottomTeamRanking = APIModel()
    var alliance: AllianceModel

    var body: some View {
        VStack {
            HStack {
                Text(alliance.teams[0].number)
                    .font(.callout)
                Spacer()
                if topTeamRanking.isLoading{
                    ProgressView()
                        .controlSize(.mini)
                }
                if let rankings = topTeamRanking.rankings {
                    Text("\(rankings.wins ?? 0)/\(rankings.losses ?? 0)/\(rankings.ties ?? 0)")
                        .font(.subheadline)
                }
            }
            .padding(.bottom, -0.2)
            HStack {
                Text(alliance.teams[1].number)
                    .font(.callout)
                Spacer()
                if topTeamRanking.isLoading {
                    ProgressView()
                        .controlSize(.mini)
                }
                if let rankings = bottomTeamRanking.rankings {
                    Text("\(rankings.wins ?? 0)/\(rankings.losses ?? 0)/\(rankings.ties ?? 0)")
                        .font(.subheadline)
                }
            }
            .padding(.top, -0.2)
        }
        .padding(.leading, 13)
        .padding(.trailing, 13)
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(
            Group {
                if let _ = alliance.indexFor(team: state.userTeam.id) {
                    RoundedRectangle(cornerRadius: 6.0).foregroundStyle(alliance.color == "blue" ? .blueAlliance : .redAlliance)
                } else {
                    RoundedRectangle(cornerRadius: 6.0).strokeBorder(alliance.color == "blue" ? .blueAlliance : .redAlliance, lineWidth: 2)
                }
            }
        )
        .task {
            try? await topTeamRanking.fetchRankings(state: state, teamID: alliance.teams[0].id)
        }
        .task {
            try? await bottomTeamRanking.fetchRankings(state: state, teamID: alliance.teams[1].id)
        }
    }
}

extension AllianceTileView {
    @Observable class APIModel {
        private(set) var rankings: RankingsModel?
        private(set) var isLoading = false
        
        @MainActor func fetchRankings(state: StateController, teamID: Int) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = RankingsResource(teamID, state.focusedCompetitionID)
            let request = RankingsRequest(resource: resource)
            rankings = try await request.execute().rankings.first
        }
    }
}

#Preview {
    AllianceTileView(alliance: .preview)
        .environmentObject(StateController())
}
