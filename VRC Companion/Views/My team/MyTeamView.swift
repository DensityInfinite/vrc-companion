//
//  MyTeam.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct MyTeamView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("monkey.kaboom")
            }
            .navigationTitle("My Team")
        }
    }
}

#Preview {
    MyTeamView()
}
