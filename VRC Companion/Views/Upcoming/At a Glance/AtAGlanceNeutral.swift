//
//  AtAGlance.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AtAGlanceNeutral: View {
    var match: MatchModel
    
    var body: some View {
        VStack(alignment: .center) {
            if let time = match.scheduledTime {
                Text("Scheduled start")
                    .fontWidth(.condensed)
                    .opacity(0.4)
                Text(time.formatted(.relative(presentation: .numeric)).capitalized)
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
                Text(time.formatted(date: .omitted, time: .shortened))
                    .fontWidth(.condensed)
                    .opacity(0.4)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .listRowBackground(Color(.neutral))
    }
}

#Preview {
    AtAGlanceNeutral(match: .preview)
}
