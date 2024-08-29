//
//  WinLossTieGraph.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct WinLossTieGraph: View {
    /// Minimal bar length used when the value associated with the bar is 0 to maintain its visibility.
    private let minBarLength: CGFloat = 10
    
    var wins: Int
    var losses: Int
    var ties: Int
    var totals: Int {
        return wins + losses + ties
    }

    var body: some View {
        return GeometryReader { proxy in
            let totalWidth = proxy.size.width
            let numOfZeroes = [wins, losses, ties].filter({ $0 % 2 == 0 }).count
            let availableWidth = totalWidth - CGFloat(numOfZeroes) * minBarLength - 2 * (totalWidth / 300)
            
            // Calculate the proportional lengths
            // TODO: Fix total length not using the entire width of the container.
            let winLength = CGFloat(wins) / CGFloat(max(totals, 1)) * availableWidth
            let lossLength = CGFloat(losses) / CGFloat(max(totals, 1)) * availableWidth
            let tieLength = CGFloat(ties) / CGFloat(max(totals, 1)) * availableWidth
            
            HStack(alignment: .center, spacing: totalWidth / 300) { // There might be a more elegant way to calculate bar spacing
                VStack {
                    Text(String(wins))
                        .font(.caption)
                        .padding(.bottom, -8)
                    if wins == 0 && losses == 0 && ties == 0 {
                        WinLossTieBar(barType: .win, length: totalWidth / 3)
                    } else {
                        WinLossTieBar(barType: .win, length: max(winLength, minBarLength))
                    }
                }
                VStack {
                    Text(String(losses))
                        .font(.caption)
                        .padding(.bottom, -8)
                    if wins == 0 && losses == 0 && ties == 0 {
                        WinLossTieBar(barType: .loss, length: totalWidth / 3)
                    } else {
                        WinLossTieBar(barType: .loss, length: max(lossLength, minBarLength))
                    }
                }
                VStack {
                    Text(String(ties))
                        .font(.caption)
                        .padding(.bottom, -8)
                    if wins == 0 && losses == 0 && ties == 0 {
                        WinLossTieBar(barType: .tie, length: totalWidth / 3)
                    } else {
                        WinLossTieBar(barType: .tie, length: max(tieLength, minBarLength))
                    }
                }
            }
        }
    }
}

#Preview {
    WinLossTieGraph(wins: 8, losses: 9, ties: 0)
        .frame(height: 20)
}
