//
//  Upcoming.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct UpcomingView: View {
    var body: some View {
        NavigationStack {
            List {
                LargeMatchRow(matchIdentifier: "Qualification 1", matchTime: Date.now.addingTimeInterval(+300))
                SmallMatchRow(matchIdentifier: "Qualification 5", matchTime: Date.now.addingTimeInterval(+7200))
                SmallMatchRow(matchIdentifier: "Qualification 7", matchTime: Date.now.addingTimeInterval(+7800))
            }
            .navigationTitle("Upcoming")
        }
    }
}

#Preview {
    UpcomingView()
}
