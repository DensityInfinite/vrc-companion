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
                Spacer()
                if matchTime.timeIntervalSinceNow.isLess(than: 300) {
                    Text("Queue now")
                        .foregroundStyle(.gray)
                } else {
                    Text(matchTime.formatted(.relative(presentation: .numeric)))
                        .foregroundStyle(.gray)
                }
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
