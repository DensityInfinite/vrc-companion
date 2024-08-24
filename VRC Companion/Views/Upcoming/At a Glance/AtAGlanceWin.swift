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
            Text("\(match.alliances[1].score!) - \(match.alliances[0].score!)")
                .fontWidth(.condensed)
                .opacity(0.4)
            
            if abs(match.alliances[0].score! - match.alliances[1].score!) != 0 {
                Text("Victory")
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
            } else {
                Text("Tied")
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
            }
            
            if match.name.localizedStandardContains("Qualifier") {
                if abs(match.alliances[0].score! - match.alliances[1].score!) != 0 {
                    Text("+2 WP (and maybe 1 AWP)")
                        .fontWidth(.condensed)
                        .opacity(0.4)
                } else {
                    Text("+1 WP (and maybe 1 AWP)")
                        .fontWidth(.condensed)
                        .opacity(0.4)
                }
            } else if match.name.localizedStandardContains("Practice") {
                Text("Keep it up for qualifiers!")
                    .fontWidth(.condensed)
                    .opacity(0.4)

            } else {
                Text("Great match!") //TODO: Replace with better messages
                    .fontWidth(.condensed)
                    .opacity(0.4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .listRowBackground(Color(.success))
    }
}

#Preview {
    AtAGlanceWin(match: .preview)
}
