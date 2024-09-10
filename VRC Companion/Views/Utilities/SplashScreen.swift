//
//  SplashScreen.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 27/8/2024.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12.632))
                .padding(.top)
            Text("Welcome to VRC Companion")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text("An extremely agile VEX Robotics Competition assistant to keep you updated on your matches, teams, and events.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.leading)
                .padding(.trailing)
            Spacer()
            VStack(alignment: .leading) {
                SplashScreenRow(image: "chevron.forward.2", headline: "Upcoming matches", subheadline: "See all your upcoming matches at a glance, filled with live statistics.")
                    .padding(.bottom)
                SplashScreenRow(image: "star.fill", headline: "Watchlist", subheadline: "Quickly access information of your potential Alliance Partners, or rivals.")
                    .padding(.bottom)
                SplashScreenRow(image: "info", headline: "Tailored to you", subheadline: "All information are pulled just for you, so your team can perform your best.")
                    .padding(.bottom)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.leading)
            .padding(.trailing)
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                ZStack {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.background)
                        .frame(height: 45)
                        .containerRelativeFrame(.horizontal, { length, axis in
                            if axis == .vertical {
                                return length / 3.0
                            } else {
                                return length / 1.3
                            }
                        })
                        .background(RoundedRectangle(cornerRadius: 12))
                }
            })
            Spacer()
        }
    }
}

#Preview {
    SplashScreen()
}
