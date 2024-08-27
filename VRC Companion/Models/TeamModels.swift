//
//  TeamModels.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 22/6/2024.
//

import Foundation
import SwiftData

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
        sitting = try container.decode(Bool.self, forKey: .sitting)

        let infoContainer = try container.nestedContainer(keyedBy: InfoKeys.self, forKey: .team)
        id = try infoContainer.decode(Int.self, forKey: .id)
        number = try infoContainer.decode(String.self, forKey: .number)
    }
}

// MARK: - RankingsModel

struct RankingsModel: Decodable {
    let team: IDInfoModel
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
        case team, rank, wp, ap, sp, wins, losses, ties
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

@Model
class TeamInfoModel: Decodable, Identifiable {
    let id: Int
    let number: String
    let name: String
    let robotName: String?
    let organization: String
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

    init(id: Int,
         number: String,
         name: String,
         robotName: String? = nil,
         organization: String,
         location: LocationModel,
         registered: Bool,
         program: IDInfoModel,
         grade: String)
    {
        self.id = id
        self.number = number
        self.name = name
        self.robotName = robotName
        self.organization = organization
        self.location = location
        self.registered = registered
        self.program = program
        self.grade = grade
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        number = try container.decode(String.self, forKey: .number)
        name = try container.decode(String.self, forKey: .name)
        robotName = try container.decodeIfPresent(String.self, forKey: .robotName)
        organization = try container.decode(String.self, forKey: .organization)
        location = try container.decode(LocationModel.self, forKey: .location)
        registered = try container.decode(Bool.self, forKey: .registered)
        program = try container.decode(IDInfoModel.self, forKey: .program)
        grade = try container.decode(String.self, forKey: .grade)
    }
}

// MARK: - LocationModel

@Model
class LocationModel: Decodable {
    let venue: String?
    let address1: String
    let address2: String?
    let city: String
    let region: String?
    let postcode: String
    let country: String
    let coordinates: CoordinatesModel

    enum CodingKeys: String, CodingKey {
        case venue
        case address1 = "address_1"
        case address2 = "address_2"
        case city, region, postcode, country, coordinates
    }

    init(venue: String? = nil,
         address1: String,
         address2: String? = nil,
         city: String,
         region: String? = nil,
         postcode: String,
         country: String,
         coordinates: CoordinatesModel)
    {
        self.venue = venue
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.region = region
        self.postcode = postcode
        self.country = country
        self.coordinates = coordinates
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        venue = try container.decodeIfPresent(String.self, forKey: .venue)
        address1 = try container.decode(String.self, forKey: .address1)
        address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        city = try container.decode(String.self, forKey: .city)
        region = try container.decodeIfPresent(String.self, forKey: .region)
        postcode = try container.decode(String.self, forKey: .postcode)
        country = try container.decode(String.self, forKey: .country)
        coordinates = try container.decode(CoordinatesModel.self, forKey: .coordinates)
    }
}

// MARK: - CoordinatesModel

@Model
class CoordinatesModel: Decodable {
    let lat: Double
    let lon: Double

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
    }

    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
    }
}

// MARK: - ProgramModel

@Model
class IDInfoModel: Decodable {
    let id: Int
    let name: String
    let code: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case code
    }

    init(id: Int, name: String, code: String? = nil) {
        self.id = id
        self.name = name
        self.code = code
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        code = try container.decodeIfPresent(String.self, forKey: .code)
    }
}
