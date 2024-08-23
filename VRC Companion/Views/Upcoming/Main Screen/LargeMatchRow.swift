//
//  LargeMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct LargeMatchRow: View {
    var match: MatchModel
    @EnvironmentObject var state: StateController

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(match.name)
                Spacer()
                if let time = match.scheduledTime {
                    if time.timeIntervalSinceNow.isLess(than: 300) {
                        Text("Queue now")
                            .foregroundStyle(.gray)
                            .fontWeight(.medium)
                    } else {
                        Text(time.formatted(.relative(presentation: .numeric)))
                            .foregroundStyle(.gray)
                    }
                }
            }
            HStack {
                if !match.name.localizedStandardContains("Qualifier") && !match.name.localizedStandardContains("Practice") {
                    AllianceTileView(alliance: match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)!)
                        .environmentObject(state)
                } else {
                    AllianceTileView(alliance: match.alliances[0])
                        .environmentObject(state)
                    AllianceTileView(alliance: match.alliances[1])
                        .environmentObject(state)

                }
            }
        }
    }
}

#Preview {
    LargeMatchRow(match: .preview)
        .environmentObject(StateController())
}
