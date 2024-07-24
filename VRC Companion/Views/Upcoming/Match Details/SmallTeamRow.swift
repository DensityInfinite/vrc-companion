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
//                if let name = team.name {
//                    Text(name)
//                        .font(.subheadline)
//                        .foregroundStyle(Color(.gray))
//                }
            }
            Spacer()
//            if let ranking = team.localRanking {
//                Text("#\(String(ranking))")
//            }
        }
    }
}

#Preview {
    SmallTeamRow(team: .preview)
}
