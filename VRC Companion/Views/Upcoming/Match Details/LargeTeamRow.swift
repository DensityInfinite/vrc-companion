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
    
    /// Controls the presentation of the associated sheet in the parent view.
    @Binding var presentingSheet: Bool

    var body: some View {
        VStack {
            HStack {
                Text(team.number)
                Spacer()
                if let rank = rankings.rank {
                    Text("#\(String(rank))")
                        .foregroundStyle(.secondary)
                }
                Button(action: {
                    presentingSheet.toggle()
                }, label: {
                    Label("Lookup this team", systemImage: "magnifyingglass")
                        .labelStyle(.iconOnly)
                })
            }
            StatsBoard(rankings: rankings, appearance: .minimal)
        }
    }
}

#Preview {
    @State var binding: Bool = false
    return LargeTeamRow(team: .preview, rankings: .preview, presentingSheet: $binding)
}
