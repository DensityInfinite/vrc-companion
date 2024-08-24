//
//  LargeTeamRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 26/6/2024.
//

import SwiftUI

struct SmallTeamRow: View {
    var team: AllianceTeamModel
    
    var body: some View {
        HStack {
            VStack {
                Text(team.number)
           }
            Spacer()
        }
    }
}

#Preview {
    SmallTeamRow(team: .preview)
}
