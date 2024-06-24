//
//  AtAGlance.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AtAGlance: View {
    var match: MatchModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Scheduled start in")
                .fontWidth(.condensed)
                .foregroundStyle(.gray)
            Text("36 Minutes")
                .font(.system(size: 65))
                .fontWidth(.compressed)
                .shadow(radius: 8)
            Text("9:36 am")
                .fontWidth(.condensed)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.neutral)
        )
    }
}

#Preview {
    AtAGlance(match: .preview)
}
