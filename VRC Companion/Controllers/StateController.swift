//
//  StateController.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 12/6/2024.
//

import Foundation

final class StateController: ObservableObject {
    @Published var userAllianceTeam: AllianceTeamModel = AllianceTeamModel(id: 150122, number: "1051X", sitting: false)
    @Published var focusedCompetitionID: Int? = 52110 // Nationals Event ID
}
