//
//  AllianceTile.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct AllianceTile: View {
    var height: CGFloat
    
    var isBlueAlliance: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6.0)
                .foregroundStyle(isBlueAlliance ? Color("BlueAlliance").opacity(0.34) : Color("RedAlliance").opacity(0.34))
                .frame(height: height)
            VStack {
                HStack {
                    Text("Team 1")
                        .font(.headline)
                    Spacer()
                    Text("0/0/0")
                        .font(.subheadline)
                }
                .padding(.bottom, 1)
                HStack {
                    Text("Team 2")
                        .font(.headline)
                    Spacer()
                    Text("0/0/0")
                        .font(.subheadline)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AllianceTile(height: 70.0, isBlueAlliance: true)
}
