//
//  ErrorView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 21/8/2024.
//

import SwiftUI

struct ErrorView: View {
    let error: ErrorWrapper

    var body: some View {
        VStack {
            Image(systemName: error.image)
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundColor(.gray)
            Text(error.guidance)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    ErrorView(error: .preview)
}
