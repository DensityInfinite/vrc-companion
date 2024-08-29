//
//  StatsBoard.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct StatsBoard: View {
    var rankings: RankingsModel
    var appearance: Appearance

    enum Appearance {
        case full, minimal
    }
    
    var body: some View {
        VStack(alignment: .center) {
            WinLossTieGraph(wins: rankings.wins ?? 0, losses: rankings.losses ?? 0, ties: rankings.ties ?? 0)
                .frame(height: 21)
            HStack {
                if let wp = rankings.wp {
                    switch appearance {
                    case .full:
                        StatsTile(data: Double(wp), description: "WP", appearance: .full)
                    case .minimal:
                        StatsTile(data: Double(wp), description: "WP", appearance: .minimal)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                if let awp = rankings.ap {
                    switch appearance {
                    case .full:
                        StatsTile(data: Double(awp), description: "AWP", appearance: .full)
                    case .minimal:
                        StatsTile(data: Double(awp), description: "AWP", appearance: .minimal)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                if let sp = rankings.sp {
                    switch appearance {
                    case .full:
                        StatsTile(data: Double(sp), description: "SP", appearance: .full)
                    case .minimal:
                        StatsTile(data: Double(sp), description: "SP", appearance: .minimal)
                            .fontWeight(.bold)
                    }
                }
            }
            HStack {
                if let highScore = rankings.highScore {
                    StatsTile(data: Double(highScore), description: "HIGH", appearance: .minimal)
                }
                Spacer()
                if let average = rankings.average {
                    StatsTile(data: Double(average), description: "AVG", appearance: .minimal)
                }
                Spacer()
                if let total = rankings.total {
                    StatsTile(data: Double(total), description: "TTL", appearance: .minimal)
                }
            }
        }
    }
}

#Preview {
    StatsBoard(rankings: .preview, appearance: .minimal)
}
