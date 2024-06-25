//
//  TeamModels.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 22/6/2024.
//

import Foundation

struct AllianceModel: Decodable {
    let color: String
    let score: Int
    let teams: [TeamModel]
    
    func findTeam(_ id: Int) -> Int? {
        for (teamIndex, team) in teams.enumerated() {
            if team.id == Int(id) {
                return teamIndex
            }
        }
        return nil
    }
}

struct TeamModel: Identifiable {
    let id: Int
    let number: String
    let name: String?
    let sitting: Bool
}

extension TeamModel: Decodable {
    enum CodingKeys: CodingKey {
        case team, sitting
    }
    
    enum InfoKeys: String, CodingKey {
        case id
        case number = "name"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sitting = try container.decode(Bool.self, forKey: .sitting)
        
        let infoContainer = try container.nestedContainer(keyedBy: InfoKeys.self, forKey: .team)
        self.id = try infoContainer.decode(Int.self, forKey: .id)
        self.number = try infoContainer.decode(String.self, forKey: .number)
        self.name = nil
        #warning("Team names need to be stored")
    }
}
