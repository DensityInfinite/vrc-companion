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
                ForEach(matchlist.matches[...2]) { match in
                    NavigationLink(destination: MatchDetails(match: match)) {
                        LargeMatchRow(match: match)
                    }
                }
                ForEach(matchlist.matches[3...]) {match in
                    NavigationLink(destination: MatchDetails(match: match)) {
                        SmallMatchRow(match: match)
                    }
                }
            }
            .navigationTitle("Upcoming")
        }
    }
}

#Preview {
    UpcomingView(matchlist: .preview)
}
