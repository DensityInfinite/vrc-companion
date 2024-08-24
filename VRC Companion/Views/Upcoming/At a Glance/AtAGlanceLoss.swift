//
//  AtAGlanceLoss.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AtAGlanceLoss: View {
    var match: MatchModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(match.alliances[1].score!) - \(match.alliances[0].score!)")
                .fontWidth(.condensed)
                .opacity(0.4)
            Text("Unlucky")
                .font(.system(size: 65))
                .fontWidth(.compressed)
                .shadow(radius: 8)
            Text("Lost by \(abs(match.alliances[0].score! - match.alliances[1].score!))")
                .fontWidth(.condensed)
                .opacity(0.4)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .listRowBackground(Color(.failed))
    }
}

#Preview {
    AtAGlanceLoss(match: .preview)
}
