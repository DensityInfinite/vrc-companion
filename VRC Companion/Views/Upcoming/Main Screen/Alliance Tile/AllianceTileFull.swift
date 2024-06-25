//
//  AllianceTileFull.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/6/2024.
//

import SwiftUI

struct AllianceTileFull: View {
    var alliance: AllianceModel
    
    var body: some View {
        VStack {
            HStack {
                Text(alliance.teams[0].number)
                    .font(.callout)
                Spacer()
                Text("0/0/0") // TODO: Add actual data from WLT
                    .font(.subheadline)
            }
            HStack {
                Text(alliance.teams[1].number)
                    .font(.callout)
                Spacer()
                Text("0/0/0") // TODO: Add actual data from WLT
                    .font(.subheadline)
            }
        }
        .padding(.leading, 13)
        .padding(.trailing, 13)
        .padding(.top, 8)
        .padding(.bottom, 8)
        .background(
            RoundedRectangle(cornerRadius: 6.0)
                .foregroundStyle(alliance.color == "blue" ? .blueAlliance : .redAlliance)
        )
    }
}

#Preview {
    AllianceTileFull(alliance: .preview)
}
