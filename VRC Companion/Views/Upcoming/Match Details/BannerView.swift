//
//  BannerView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/6/2024.
//

import SwiftUI

struct BannerView: View {
    @Environment(StateController.self) var state
    var match: MatchModel?
    var systemImage: String?
    var message: String?
    var color: Color?

    var body: some View {
        if let match {
            if let alliance = match.allianceForTeam(id: state.userTeamInfo.id, side: .team) {
                if alliance.color == "blue" {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.blueAllianceSolid)
                            .fontWeight(.bold)
                        Text("You are part of the Blue Alliance")
                    }
                    .listRowBackground(Color(.blueAlliance).opacity(0.5))
                } else {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.redAllianceSolid)
                            .fontWeight(.bold)
                        Text("You are part of the Red Alliance")
                    }
                    .listRowBackground(Color(.redAlliance).opacity(0.5))
                }
            }
        } else {
            if let systemName = systemImage, let message, let color {
                HStack {
                    Image(systemName: systemName)
                    Text(message)
                }
                .listRowBackground(color)
            }
        }
    }
}

#Preview {
    BannerView(match: .preview)
        .environment(StateController())
}
