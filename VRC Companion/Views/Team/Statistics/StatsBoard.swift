//
//  StatsBoard.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct StatsBoard: View {
    var rankings: RankingsModel
    var representation: Representation

    enum Representation {
        case full, minimal
    }
    
    var body: some View {
        VStack(alignment: .center) {
            WinLossTieGraph(wins: rankings.wins ?? 0, losses: rankings.losses ?? 0, ties: rankings.ties ?? 0)
                .frame(height: 21)
            HStack {
                if let wp = rankings.wp {
                    switch representation {
                    case .full:
                        StatsTile(data: Double(wp), description: "WP", representation: .full)
                    case .minimal:
                        StatsTile(data: Double(wp), description: "WP", representation: .minimal)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                if let awp = rankings.ap {
                    switch representation {
                    case .full:
                        StatsTile(data: Double(awp), description: "AWP", representation: .full)
                    case .minimal:
                        StatsTile(data: Double(awp), description: "AWP", representation: .minimal)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
                if let sp = rankings.sp {
                    switch representation {
                    case .full:
                        StatsTile(data: Double(sp), description: "SP", representation: .full)
                    case .minimal:
                        StatsTile(data: Double(sp), description: "SP", representation: .minimal)
                            .fontWeight(.bold)
                    }
                }
            }
            HStack {
                if let highScore = rankings.highScore {
                    StatsTile(data: Double(highScore), description: "HIGH", representation: .minimal)
                }
                Spacer()
                if let average = rankings.average {
                    StatsTile(data: Double(average), description: "AVG", representation: .minimal)
                }
                Spacer()
                if let total = rankings.total {
                    StatsTile(data: Double(total), description: "TTL", representation: .minimal)
                }
            }
        }
    }
}

#Preview {
    StatsBoard(rankings: .preview, representation: .minimal)
}
