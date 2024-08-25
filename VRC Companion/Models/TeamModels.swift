//
//  TeamModels.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 22/6/2024.
//

import Foundation

// MARK: - AllianceModel
struct AllianceModel: Decodable {
    let color: String
    let score: Int?
    let teams: [AllianceTeamModel]
    
    func indexFor(team id: Int) -> Int? {
        for (teamIndex, team) in teams.enumerated() {
            if team.id == Int(id) {
                return teamIndex
            }
        }
        return nil
    }
}

// MARK: - AllianceTeamModel
struct AllianceTeamModel: Identifiable {
    let id: Int
    let number: String
    let sitting: Bool
}

extension AllianceTeamModel: Decodable {
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
    }
}

// MARK: - RankingsModel
struct RankingsModel: Decodable {
    let rank: Int?
    
    let wp: Int?
    let ap: Int?
    let sp: Int?
    
    let wins: Int?
    let losses: Int?
    let ties: Int?
    
    let highScore: Int?
    let average: Double?
    let total: Int?
}

extension RankingsModel {
    enum CodingKeys: String, CodingKey {
        case rank, wp, ap, sp, wins, losses, ties
        case highScore = "high_score"
        case average = "average_points"
        case total = "total_points"
    }
}

struct APIRankingsModel: Decodable {
    let meta: Meta
    let rankings: [RankingsModel]
}

extension APIRankingsModel {
    enum CodingKeys: String, CodingKey {
        case rankings = "data"
        case meta
    }
}

// MARK: - TeamInfoModel
struct TeamInfoModel: Decodable {
    let id: Int
    let number, name, robotName, organization: String
    let location: LocationModel
    let registered: Bool
    let program: IDInfoModel
    let grade: String
    
    enum CodingKeys: String, CodingKey {
        case id, number
        case name = "team_name"
        case robotName = "robot_name"
        case organization, location, registered, program, grade
    }
}

// MARK: - LocationModel
struct LocationModel: Decodable {
    let venue: String?
    let address1: String
    let address2: String?
    let city: String
    let region: String?
    let postcode, country: String
    let coordinates: CoordinatesModel
    
    enum CodingKeys: String, CodingKey {
        case venue
        case address1 = "address_1"
        case address2 = "address_2"
        case city, region, postcode, country, coordinates
    }
}

// MARK: - CoordinatesModel
struct CoordinatesModel: Decodable {
    let lat, lon: Double
}

// MARK: - ProgramModel
struct IDInfoModel: Decodable {
    let id: Int
    let name, code: String
}

