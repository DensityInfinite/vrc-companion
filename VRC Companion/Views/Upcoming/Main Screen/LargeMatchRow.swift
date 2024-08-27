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
    var presentingWLT: Bool?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(match.name)
                Spacer()
                if let time = match.scheduledTime {
                    if time.timeIntervalSinceNow.isLess(than: 300) {
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
