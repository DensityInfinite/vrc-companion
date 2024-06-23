//
//  AllianceTile.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct AllianceTile: View {
    var height: CGFloat
    var alliance: AllianceModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6.0)
                .foregroundStyle(alliance.color == "blue" ? Color("BlueAlliance").opacity(0.34) : Color("RedAlliance").opacity(0.34))
                .frame(height: height)
            VStack {
                HStack {
                    Text(alliance.teams[0].number)
                        .font(.headline)
                    Spacer()
                    Text("0/0/0") //TODO: Add actual data from WLT
                        .font(.subheadline)
                }
                .padding(.bottom, 1)
                HStack {
                    Text(alliance.teams[1].number)
                        .font(.headline)
                    Spacer()
                    Text("0/0/0") //TODO: Add actual data from WLT
                        .font(.subheadline)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AllianceTile(height: 70.0, alliance: "blue")
}
