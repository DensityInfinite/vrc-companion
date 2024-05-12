//
//  SmallMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct SmallMatchRow: View, HoldsMatchInfo {
    var matchIdentifier: String
    var matchTime: Date
    
    var body: some View {
        HStack {
            Text(matchIdentifier)
                .font(.headline)
            Spacer()
            Text(matchTime.formatted(date: .omitted, time: .shortened))
                .font(.subheadline)
        }
    }
}

#Preview {
    SmallMatchRow(matchIdentifier: "Qualification 5", matchTime: Date.now.addingTimeInterval(+7200))
}
