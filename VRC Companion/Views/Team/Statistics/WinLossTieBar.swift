//
//  WinLossTieBar.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct WinLossTieBar: View {
    var barType: BarType
    var length: CGFloat
    var color: Color {
        switch barType {
        case .win:
            Color(.win)
        case .loss:
            Color(.lose)
        case .tie:
            Color(.gray)
        }
    }
    
    enum BarType {
        case win, loss, tie
    }
    
    var body: some View {
        Capsule()
            .fill(color)
            .frame(width: length)
    }
}

#Preview {
    WinLossTieBar(barType: .win, length: 100)
}
