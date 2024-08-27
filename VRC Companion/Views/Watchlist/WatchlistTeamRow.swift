//
//  WatchlistTeamRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 27/8/2024.
//

import SwiftUI

struct WatchlistTeamRow: View {
    var team: TeamInfoModel
    var rankings: RankingsModel
    var presentingBoard: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading) {
                    Text(team.number)
                    Text(team.name)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                if let rank = rankings.rank {
                    Text("#\(rank)")
                        .foregroundStyle(.secondary)
                }
            }
            if presentingBoard {
                StatsBoard(rankings: rankings, representation: .minimal)
            }
        }
    }
}

#Preview {
    WatchlistTeamRow(team: .preview, rankings: .preview, presentingBoard: true)
}
