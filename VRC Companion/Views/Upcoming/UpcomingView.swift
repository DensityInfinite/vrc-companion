//
//  Upcoming.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct UpcomingView: View {
    @State var matchlist: MatchlistModel
    
    var body: some View {
        NavigationStack {
            List {
                LargeMatchRow(match: matchlist.matches[0])
                ForEach(matchlist.matches[1...]) {match in
                    SmallMatchRow(match: match)
                }
            }
            .navigationTitle("Upcoming")
        }
    }
}

#Preview {
    UpcomingView(matchlist: .preview)
}
