//
//  SimpleRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

struct SimpleRow: View {
    var label: String
    var details: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(details)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    SimpleRow(label: "Row", details: "Details")
}
