//
//  MyTeam.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct MyTeamView: View {
    @EnvironmentObject var state: StateController
    
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
        .environmentObject(StateController())
}
