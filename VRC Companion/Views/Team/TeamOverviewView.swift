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
                    .minimumScaleFactor(0.1)
                    .lineLimit(0)
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
                        .foregroundStyle(.secondary)
                        .opacity(0.8)
                }
                .frame(width: 100, height: 110)
                .background(
                    Group {
                        if rank <= 10 {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.success)
                        } else if rank <= 20 {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.warning)
                        } else {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.failed)
                        }
                    }
                )
            }
        }
    }
}

#Preview {
    TeamOverviewView(teamInfo: .preview, teamRankings: .preview)
}
