//
//  TeamListRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/8/2024.
//

import SwiftUI

struct TeamListRow: View {
    var team: TeamInfoModel
    
    var body: some View {
        HStack {
            HStack(alignment: .center) {
                Text(team.number)
                    .font(.title3)
                    .fontWeight(.black)
                    .italic()
            }
            Spacer()
            Text(team.name)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    TeamListRow(team: .preview)
}
