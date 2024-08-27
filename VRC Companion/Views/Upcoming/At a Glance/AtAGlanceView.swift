//
//  AtAGlanceView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AtAGlanceView: View {
    @Environment(StateController.self) var state
    var match: MatchModel
    var isResearch: Bool

    var body: some View {
        if isResearch {
            AtAGlanceResearch(redScore: match.alliances[1].score, blueScore: match.alliances[0].score)
        } else {
            // TODO: Refactor to be more concice
            if let time = match.scheduledTime {
                if time.timeIntervalSinceNow.isLess(than: 300) {
                    if time.timeIntervalSinceNow > 0 {
                        AtAGlanceQueue(match: match)
                    } else {
                        if let userAllianceScore = match.allianceForTeam(id: state.userTeamInfo.id, side: .team)?.score, let oppositionAllianceScore = match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)?.score {
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
                if let userAllianceScore = match.allianceForTeam(id: state.userTeamInfo.id, side: .team)?.score, let oppositionAllianceScore = match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)?.score {
                    if userAllianceScore >= oppositionAllianceScore {
                        AtAGlanceWin(match: match)
                    } else {
                        AtAGlanceLoss(match: match)
                    }
                }
            }
        }
    }
}

#Preview {
    AtAGlanceView(match: .preview, isResearch: false)
        .environment(StateController())
}
