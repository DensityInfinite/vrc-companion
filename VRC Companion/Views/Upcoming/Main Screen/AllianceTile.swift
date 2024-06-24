//
//  AllianceTile.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct AllianceTile: View {
    var alliance: AllianceModel
    
    var body: some View {
        VStack {
            HStack {
                Text(alliance.teams[0].number)
                    .fontWeight(.medium)
                Spacer()
                Text("0/0/0") //TODO: Add actual data from WLT
                    .font(.subheadline)
            }
            .padding(.bottom, 1)
            HStack {
                Text(alliance.teams[1].number)
                    .fontWeight(.medium)
                Spacer()
                Text("0/0/0") //TODO: Add actual data from WLT
                    .font(.subheadline)
            }
        }
        .padding(13)
        .background(
            RoundedRectangle(cornerRadius: 6.0)
                .foregroundStyle(alliance.color == "blue" ? .blueAlliance : .redAlliance)
        )
    }
}

#Preview {
    AllianceTile(alliance: .preview)
}
