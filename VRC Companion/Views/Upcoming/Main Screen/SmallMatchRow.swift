//
//  SmallMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct SmallMatchRow: View {
    var match: MatchModel
    
    var body: some View {
        HStack {
            Text(match.name)
            Spacer()
            if let time = match.scheduledTime {
                Text(time.formatted(date: .omitted, time: .shortened))
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    SmallMatchRow(match: .preview)
}
