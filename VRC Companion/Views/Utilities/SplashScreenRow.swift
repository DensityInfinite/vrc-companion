//
//  SplashScreenRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 27/8/2024.
//

import SwiftUI

struct SplashScreenRow: View {
    var image: String
    var headline: String
    var subheadline: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundStyle(.accent)
                .imageScale(.medium)
                .frame(width: 55, height: 55)
            VStack(alignment: .leading) {
                Text(headline)
                    .font(.headline)
                Text(subheadline)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
        }
    }
}

#Preview {
    SplashScreenRow(image: "chevron.forward.2", headline: "Your upcoming matches at a glance", subheadline: "See a collection of your upcoming matches, with live team statistics, all on one screen.")
}
