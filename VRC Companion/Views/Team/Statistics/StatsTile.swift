//
//  StatsItem.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct StatsTile: View {
    var data: Double
    var description: String
    var appearance: Appearance
    
    enum Appearance {
        case full, minimal
    }
    
    var body: some View {
        switch appearance {
        case .full:
            HStack{
                Spacer()
                VStack {
                    Text(String(data.formatted()))
                        .padding(.bottom, -12)
                        .font(.system(size: 40, weight: .regular))
                        .fontWidth(.condensed)
                    Text(description)
                        .fontWidth(.condensed)
                        .foregroundStyle(.secondary)
                }
                .padding(.top)
                .padding(.bottom)
                .padding(.leading, 8)
                .padding(.trailing, 8)
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.neutral)
            )
        case .minimal:
            HStack {
                Text(description)
                    .font(.subheadline)
                    .fontWidth(.condensed)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(data.formatted()))
                    .font(.subheadline)
                    .fontWidth(.condensed)
            }
            .padding(.top, 8)
            .padding(.bottom, 8)
            .padding(.leading)
            .padding(.trailing)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.neutral)
            )
        }
    }
}

#Preview {
    StatsTile(data: 141, description: "HIGH", appearance: .full)
}
