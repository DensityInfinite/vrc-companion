//
//  Item.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
