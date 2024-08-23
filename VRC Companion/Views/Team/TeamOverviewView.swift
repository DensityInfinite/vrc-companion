//
//  TeamOverviewView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 22/8/2024.
//

import SwiftUI

struct TeamOverviewView: View {
    var teamInfo: TeamInfoModel
    var teamRankings: RankingsModel
    
    var body: some View {
        HStack {
            VStack {
                Text(teamInfo.number)
                    .font(.system(size: 60, weight: .black))
                    .italic()
                    .padding(.bottom, -15)
                Text(teamInfo.name)
                    .font(.subheadline)
                    .fontWidth(.condensed)
            }
            .padding(.leading, 4)
            .padding(.top)
            .padding(.bottom)
            
            Spacer()
            
            if let rank = teamRankings.rank {
                VStack {
                    Text("#\(rank)")
                        .font(.system(size: 60, weight: .regular))
                        .fontWidth(.condensed)
                        .padding(.bottom, -15)
                    Text("Seeding Rank")
                        .font(.subheadline)
                        .fontWidth(.condensed)
                        .foregroundStyle(.gray)
                }
                .frame(width: 100, height: 110)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.success)
                )
            }
        }
    }
}

#Preview {
    TeamOverviewView(teamInfo: .preview, teamRankings: .preview)
}
