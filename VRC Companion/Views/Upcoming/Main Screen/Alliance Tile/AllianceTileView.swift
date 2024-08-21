//
//  AllianceTile.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct AllianceTileView: View {
    var alliance: AllianceModel
    @EnvironmentObject var state: StateController

    var body: some View {
        VStack {
            HStack {
                Text(alliance.teams[0].number)
                    .font(.callout)
                Spacer()
                Text("0/0/0") // TODO: Add actual data from WLT
                    .font(.subheadline)
            }
            HStack {
                Text(alliance.teams[1].number)
                    .font(.callout)
                Spacer()
                Text("0/0/0") // TODO: Add actual data from WLT
                    .font(.subheadline)
            }
        }
        .padding(.leading, 13)
        .padding(.trailing, 13)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(
            Group {
                if let _ = alliance.indexFor(team: state.userTeam.id) {
                    RoundedRectangle(cornerRadius: 6.0).foregroundStyle(alliance.color == "blue" ? .blueAlliance : .redAlliance)
                } else {
                    RoundedRectangle(cornerRadius: 6.0).strokeBorder(alliance.color == "blue" ? .blueAlliance : .redAlliance, lineWidth: 2)
                }
            }
        )
    }
}

#Preview {
    AllianceTileView(alliance: .preview)
        .environmentObject(StateController())
}
