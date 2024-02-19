//
//  Upcoming.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct Upcoming: View {
    var body: some View {
        NavigationSplitView {
            List {
                LargeMatchRow()
                SmallMatchRow()
                SmallMatchRow()
            }
            .navigationTitle("Upcoming")
        } detail: {
            Text("Select a match to see details.")
        }
    }
}

#Preview {
    Upcoming()
}
