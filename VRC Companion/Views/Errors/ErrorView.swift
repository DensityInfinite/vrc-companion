//
//  ErrorView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 21/8/2024.
//

import SwiftUI

/// Presents a large, grayscale error message.
struct ErrorView: View {
    let error: ErrorWrapper

    var body: some View {
        VStack {
            Image(systemName: error.image)
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.secondary)
            Text(error.guidance)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ErrorView(error: .preview)
}
