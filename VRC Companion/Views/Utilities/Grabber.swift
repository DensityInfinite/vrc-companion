//
//  Grabber.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct Grabber: View {
    var body: some View {
        Capsule()
            .fill(.placeholder)
            .opacity(0.5)
            .frame(width: 60, height: 5)
            .padding(.top, 5)
    }
}

#Preview {
    Grabber()
}
