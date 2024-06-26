//
//  LargeMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct LargeMatchRow: View {
    var match: MatchModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(match.name)
                Spacer()
                if let time = match.scheduledTime {
                    if time.timeIntervalSinceNow.isLess(than: 300) {
                        Text("Queue now")
                            .foregroundStyle(.gray)
                            .fontWeight(.medium)
                    } else {
                        Text(time.formatted(.relative(presentation: .numeric)))
                            .foregroundStyle(.gray)
                    }
                }
            }
            HStack {
                AllianceTileView(alliance: match.alliances[0])
                    .environmentObject(StateController())
                AllianceTileView(alliance: match.alliances[1])
                    .environmentObject(StateController())
            }
        }
    }
}

#Preview {
    LargeMatchRow(match: .preview)
}