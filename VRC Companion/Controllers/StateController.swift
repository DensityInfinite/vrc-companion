//
//  StateController.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 12/6/2024.
//

import Foundation

@Observable
final class StateController {
    // The following sets the user as 1051X Siege, and the focused competition as the 2023 AUS Nationals
    var userTeamInfo: TeamInfoModel = .init(id: 150122, number: "1051X", name: "Siege", robotName: "Scot", organization: "The Scots College Sydney", location: LocationModel(venue: nil, address1: "", address2: nil, city: "Sydney", region: nil, postcode: String(2023), country: "Australia", coordinates: CoordinatesModel(lat: -33.899999999999999, lon: 151.30000000000001)), registered: false, program: IDInfoModel(id: 1, name: "VEX V5 Robotics Competition", code: "V5RC"), grade: "High School")
    var userRankings: RankingsModel = .init(team: IDInfoModel(id: 150112, name: "1051X"), rank: 1, wp: 18, ap: 64, sp: 793, wins: 8, losses: 1, ties: 0, highScore: 113, average: 113.44, total: 1021)
    var focusedCompetitionID: Int? = 52110
}
