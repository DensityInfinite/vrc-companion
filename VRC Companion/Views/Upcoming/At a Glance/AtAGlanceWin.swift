//
//  AtAGlanceWin.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AtAGlanceWin: View {
    var match: MatchModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(match.alliances[0].score) - \(match.alliances[1].score)")
                .fontWidth(.condensed)
                .foregroundStyle(Color.primary.opacity(0.4))
            Text("Victory")
                .font(.system(size: 65))
                .fontWidth(.compressed)
                .shadow(radius: 8)
            Text("+4 WP, 1 AWP") //FIXME: Actual data needed here
                .fontWidth(.condensed)
                .foregroundStyle(Color.primary.opacity(0.4))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .listRowBackground(Color(.success))
    }
}

#Preview {
    AtAGlanceWin(match: .preview)
}
