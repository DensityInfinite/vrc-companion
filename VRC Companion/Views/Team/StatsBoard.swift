//
//  StatsBoard.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct StatsBoard: View {
    var rankings: RankingsModel
    
    var body: some View {
        VStack {
            HStack {
                if let wp = rankings.wp {
                    StatsTile(data: Double(wp), description: "WP", representation: .full)
                }
                Spacer()
                if let awp = rankings.ap {
                    StatsTile(data: Double(awp), description: "AWP", representation: .full)
                }
                Spacer()
                if let sp = rankings.sp {
                    StatsTile(data: Double(sp), description: "SP", representation: .full)
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
    StatsBoard(rankings: .preview)
}
