//
//  SmallMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct SmallMatchRow: View {
    var body: some View {
        HStack {
            Text("Match Identifier")
                .font(.headline)
            Spacer()
            Text("10:17am")
                .font(.subheadline)
        }
    }
}

#Preview {
    SmallMatchRow()
}
