//
//  AtAGlanceView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AtAGlanceView: View {
    var match: MatchModel
    @EnvironmentObject var state: StateController

    var body: some View {
        if let time = match.scheduledTime {
            if time.timeIntervalSinceNow.isLess(than: 300) {
                if time.timeIntervalSinceNow > 0 {
                    AtAGlanceQueue(match: match)
                } else {
                    if let userAllianceScore = match.allianceForTeam(id: state.userAllianceTeam.id, side: .team)?.score, let oppositionAllianceScore = match.allianceForTeam(id: state.userAllianceTeam.id, side: .opposition)?.score {
                        if userAllianceScore >= oppositionAllianceScore {
                            AtAGlanceWin(match: match)
                        } else {
                            AtAGlanceLoss(match: match)
                        }
                    }
                }
            } else {
                AtAGlanceNeutral(match: match)
            }
        } else {
            if let userAllianceScore = match.allianceForTeam(id: state.userAllianceTeam.id, side: .team)?.score, let oppositionAllianceScore = match.allianceForTeam(id: state.userAllianceTeam.id, side: .opposition)?.score {
                if userAllianceScore >= oppositionAllianceScore {
                    AtAGlanceWin(match: match)
                } else {
                    AtAGlanceLoss(match: match)
                }
            }
        }
    }
}

#Preview {
    AtAGlanceView(match: .preview)
        .environmentObject(StateController())
}
