//
//  LargeTeamRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct LargeTeamRow: View {
    var team: AllianceTeamModel
    var rankings: RankingsModel
    @Binding var presentingSheet: Bool

    var body: some View {
        VStack {
            HStack {
                Text(team.number)
                Spacer()
                if let rank = rankings.rank {
                    Text("#\(String(rank))")
                        .foregroundStyle(.gray)
                }
                Button("", systemImage: "magnifyingglass", action: {
                    presentingSheet.toggle()
                })
            }
            StatsBoard(rankings: rankings)
        }
    }
}

#Preview {
    @State var binding: Bool = false
    return LargeTeamRow(team: .preview, rankings: .preview, presentingSheet: $binding)
}
