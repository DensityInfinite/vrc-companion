//
//  Upcoming.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject var state: StateController

    var matchlist: MatchlistModel

    var body: some View {
        NavigationStack {
            List(matchlist.matches, id: \.id, rowContent: { match in
                NavigationLink {
                    MatchDetails(match: match).environmentObject(state)
                } label: {
                    LargeMatchRow(match: match)
                }
            })
            .navigationTitle("Upcoming")
        }
    }
}

#Preview {
    UpcomingView(matchlist: .preview)
        .environmentObject(StateController())
}
