//
//  BannerView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/6/2024.
//

import SwiftUI

struct BannerView: View {
    @EnvironmentObject var state: StateController
    var match: MatchModel

    var body: some View {
        if let (allianceIndex, _) = match.findTeam(state.userTeam.id) {
            if match.alliances[allianceIndex].color == "blue" {
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
    }
}

#Preview {
    BannerView(match: .preview)
        .environmentObject(StateController())
}
