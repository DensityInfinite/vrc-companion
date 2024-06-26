//
//  MatchModels.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 22/6/2024.
//

import Foundation

struct MatchModel: Identifiable {
    let id: Int
    let name: String
    let event: IdInfo
    let division: IdInfo
    
    let round: Int
    let instance: Int
    let matchNum: Int
    let scheduledTime: Date?
    let startedTime: Date?
    let field: String?
    let session: Int
    let scored: Bool
    
    let alliances: [AllianceModel]
    
    func findTeam(_ id: Int) -> (Int, Int)? {
        for (allianceIndex, alliance) in alliances.enumerated() {
            for (teamIndex, team) in alliance.teams.enumerated() {
                if team.id == Int(id) {
                    return (allianceIndex, teamIndex)
                }
            }
        }
        return nil
    }
    
    func findTeamAlliance(_ id: Int) -> String? {
        for alliance in alliances {
            for team in alliance.teams {
                if team.id == Int(id) {
                    return alliance.color
                }
            }
        }
        return nil
    }
    
    func findOppositionAlliance(_ id: Int) -> String? {
        var color = ""
        for alliance in alliances {
            for team in alliance.teams {
                if team.id == Int(id) {
                    color = alliance.color
                }
            }
        }
        if color == "red" {
            return "blue"
        } else if color == "blue" {
            return "red"
        }
        return nil
    }
}

extension MatchModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case matchNum = "matchnum"
        case scheduledTime = "scheduled"
        case startedTime = "started"
        case id, name, event, division, round, instance, field, session, scored, alliances
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        event = try container.decode(IdInfo.self, forKey: .event)
        division = try container.decode(IdInfo.self, forKey: .division)
        
        round = try container.decode(Int.self, forKey: .round)
        instance = try container.decode(Int.self, forKey: .instance)
        matchNum = try container.decode(Int.self, forKey: .matchNum)
        scheduledTime = try container.decodeIfPresent(Date.self, forKey: .scheduledTime)
        startedTime = try container.decodeIfPresent(Date.self, forKey: .startedTime)
        field = try container.decodeIfPresent(String.self, forKey: .field)
        session = try container.decode(Int.self, forKey: .session)
        scored = try container.decode(Bool.self, forKey: .scored)
        
        alliances = try container.decode([AllianceModel].self, forKey: .alliances)
    }
}

struct MatchlistModel {
    let meta: Meta
    let matches: [MatchModel]
}

extension MatchlistModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case matches = "data"
        case meta
    }
}
