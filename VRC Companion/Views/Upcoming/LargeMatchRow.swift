//
//  LargeMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct LargeMatchRow: View, HoldsMatchInfo {
    var matchIdentifier: String
    var matchTime: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(matchIdentifier)
                    .font(.headline)
                Spacer()
                Text(matchTime.formatted(.relative(presentation: .numeric)))
                    .font(.subheadline)
            }
            HStack {
                AllianceTile(height: 70, isBlueAlliance: true)
                AllianceTile(height: 70, isBlueAlliance: false)
            }
        }
    }
}

#Preview {
    LargeMatchRow(matchIdentifier: "Qualification 1", matchTime: Date(timeIntervalSinceNow: +300))
}
