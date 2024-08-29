//
//  SimpleRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 24/8/2024.
//

import SwiftUI

// TODO: This might be redundant. Consider modifying the app structure to allow for more efficient code reuse.
struct SimpleRow: View {
    var label: String
    var details: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(details)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SimpleRow(label: "Row", details: "Details")
}
