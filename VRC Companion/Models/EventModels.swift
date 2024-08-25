//
//  EventModels.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/8/2024.
//

import Foundation

// MARK: - EventModel
struct EventInfoModel: Decodable {
    let id: Int
    let name: String
    let start, end: Date
    let season, program: IDInfoModel
    let location: LocationModel
    let divisions: [DivisionInfoModel]
    let level: String
    let ongoing, awardsFinalized: Bool
    let eventType: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, start, end, season, program, location, divisions, level, ongoing
        case awardsFinalized = "awards_finalized"
        case eventType = "event_type"
    }
}

// MARK: - DivisionInfoModel
struct DivisionInfoModel: Codable {
    let id: Int
    let name: String
    let order: Int
}
