//
//  ErrorWrapper.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 21/8/2024.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let image: String
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, image: String, guidance: String) {
        self.id = id
        self.error = error
        self.image = image
        self.guidance = guidance
    }
}

enum Errors: Error {
    case apiError
    case noSearchResults
}
