//
//  LargeMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct LargeMatchRow: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Match Identifier")
                    .font(.headline)
                Spacer()
                Text("in 5 mins")
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
    LargeMatchRow()
}
