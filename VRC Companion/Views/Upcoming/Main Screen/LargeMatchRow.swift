//
//  LargeMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct LargeMatchRow: View {
    @Environment(StateController.self) var state

    var match: MatchModel

    /// Whether the Alliance Tiles in this match row should present the Win-Loss-Tie stats.
    var presentingWLT: Bool?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(match.name)
                Spacer()
                if let time = match.scheduledTime {
                    // Displays the "queue now" text if the match is scheduled to begin in the next 5 minutes. Otherwise displays the time.
                    if time.timeIntervalSinceNow.isLess(than: 0) {
                        Text(time.formatted(date: .omitted, time: .shortened))
                            .foregroundStyle(.secondary)
                    } else if time.timeIntervalSinceNow.isLess(than: 300) {
                        Text("Queue Now")
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                    } else {
                        Text(time.formatted(.relative(presentation: .numeric)))
                            .foregroundStyle(.secondary)
                    }
                }
            }
            HStack {
                // Only present the opposition alliance for play-off matches. By then the alliance will not shuffle and the user will know its own alliance well.
                if !match.name.localizedStandardContains("Qualifier") && !match.name.localizedStandardContains("Practice") {
                    AllianceTileView(alliance: match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)!, presentingWLT: presentingWLT)
                        .environment(state)
                } else {
                    AllianceTileView(alliance: match.alliances[1], presentingWLT: presentingWLT)
                        .environment(state)
                    AllianceTileView(alliance: match.alliances[0], presentingWLT: presentingWLT)
                        .environment(state)
                }
            }
        }
    }
}

#Preview {
    LargeMatchRow(match: .preview)
        .environment(StateController())
}
