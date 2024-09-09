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
    let scored: Bool
    
    let alliances: [AllianceModel]
    
    let lastUpdated: Date?
    
    enum MatchSides {
        case team
        case opposition
    }
    
    func _indexesFor(team id: Int) -> (Int, Int)? {
        for (allianceIndex, alliance) in alliances.enumerated() {
            for (teamIndex, team) in alliance.teams.enumerated() {
                if team.id == Int(id) {
                    return (allianceIndex, teamIndex)
                }
            }
        }
        return nil
    }
    
    func team(id: Int) -> AllianceTeamModel? {
        if let (allianceIndex, teamIndex) = _indexesFor(team: id) {
            return alliances[allianceIndex].teams[teamIndex]
        }
        return nil
    }
    
    func allianceForTeam(id: Int, side: MatchSides) -> AllianceModel? {
        if let (allianceIndex, _) = _indexesFor(team: id) {
            if allianceIndex == 0 {
                if side == MatchSides.team {
                    return alliances[0]
                } else {
                    return alliances[1]
                }
            } else {
                if side == MatchSides.team {
                    return alliances[1]
                } else {
                    return alliances[0]
                }
            }
        }
        return nil
    }
}

extension MatchModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case matchNum = "matchnum"
        case scheduledTime = "scheduled"
        case startedTime = "started"
        case lastUpdated = "updated_at"
        case id, name, event, division, round, instance, field, scored, alliances
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
        scored = try container.decode(Bool.self, forKey: .scored)
        
        alliances = try container.decode([AllianceModel].self, forKey: .alliances)
        lastUpdated = try container.decodeIfPresent(Date.self, forKey: .lastUpdated)
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
