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
        if let _ = alliance.findTeam(state.userTeam.id) {
            AllianceTileFull(alliance: alliance)
        } else {
            AllianceTileBorder(alliance: alliance)
        }
    }
}


#Preview {
    AllianceTileView(alliance: .preview)
        .environmentObject(StateController())
}
