//
//  MatchDetails.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 23/2/2024.
//

import SwiftUI

struct MatchDetails: View {
    @EnvironmentObject var state: StateController
    var match: MatchModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    AtAGlanceView(match: match)
                        .environmentObject(StateController())
                        .padding(.top, -8)
                        .padding(.bottom, -8)
                }
                
                Section {
                    BannerView(match: match)
                        .environmentObject(StateController())
                }
                .listSectionSpacing(.compact)
                
                Section("Opponents - \(match.findOppositionAlliance(state.userTeam.id)!.capitalized) Alliance") {
                    
                }
                
                Section("Your Alliance") {
                    
                }
            }
            .navigationTitle(match.name)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, -30)
        }
    }
}

#Preview {
    MatchDetails(match: .preview)
        .environmentObject(StateController())
}
