//
//  AtAGlanceQueue.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AtAGlanceQueue: View {
    var match: MatchModel
    
    var body: some View {
        VStack(alignment: .center) {
            if let time = match.scheduledTime {
                Text("\(time.formatted(.relative(presentation: .numeric)))")
                    .fontWidth(.condensed)
                    .opacity(0.4)
                Text("Queue Now")
                    .font(.system(size: 65))
                    .fontWidth(.compressed)
                    .shadow(radius: 8)
                if let field = match.field {
                    Text("At \(field)")
                        .fontWidth(.condensed)
                        .opacity(0.4)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .listRowBackground(Color(.warning))
    }
}

#Preview {
    AtAGlanceQueue(match: .preview)
}
