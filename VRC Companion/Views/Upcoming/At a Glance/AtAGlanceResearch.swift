//
//  AtAGlanceBlue.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 23/8/2024.
//

import SwiftUI

struct AtAGlanceResearch: View {
    @State private var matchResult: MatchResults = .tied
    @State private var background: Color = .neutral
    var redScore: Int?
    var blueScore: Int?
    
    enum MatchResults {
        case red, blue, tied, unscored
    }

    var body: some View {
        VStack(alignment: .center) {
            if matchResult != .unscored {
                Text("\(redScore!) - \(blueScore!)")
                    .fontWidth(.condensed)
                    .opacity(0.4)
            }

            switch matchResult {
            case .red:
                Text("Red Alliance")
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
            case .blue:
                Text("Blue Alliance")
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
            case .tied:
                Text("Tied")
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
            case .unscored:
                Text("Unscored")
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
            }

            Text("is the winner")
                .fontWidth(.condensed)
                .opacity(0.4)
        }
        .onAppear {
            if let blueScore = blueScore, let redScore = redScore {
                if blueScore < redScore {
                    matchResult = .red
                    background = Color(.redAlliance)
                } else if blueScore > redScore {
                    matchResult = .blue
                    background = Color(.blueAlliance)
                }
            } else {
                matchResult = .unscored
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .listRowBackground(background)
    }
}

#Preview {
    AtAGlanceResearch(redScore: 108, blueScore: 34)
}
