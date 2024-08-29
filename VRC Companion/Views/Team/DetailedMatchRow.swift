//
//  DetailedMatchRow.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 22/8/2024.
//

import SwiftUI

struct DetailedMatchRow: View {
    /// The short form of the official match name.
    @State private var shortMatchName = ""
    
    var team: TeamInfoModel
    var match: MatchModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                if let teamScore = match.allianceForTeam(id: team.id, side: .team)?.score, let oppositionScore = match.allianceForTeam(id: team.id, side: .opposition)?.score {
                    if teamScore > oppositionScore {
                        Text(shortMatchName)
                            .font(.headline)
                            .foregroundStyle(.win)
                    } else if teamScore < oppositionScore {
                        Text(shortMatchName)
                            .font(.headline)
                            .foregroundStyle(.lose)
                    } else {
                        Text(shortMatchName)
                            .font(.headline)
                    }
                } else {
                    Text(shortMatchName)
                        .font(.headline)
                }
                if let time = match.scheduledTime {
                    Text(time.formatted(date: .omitted, time: .shortened))
                        .font(.subheadline)
                }
            }
            .frame(width: 65, alignment: .leading)
            .onAppear {
                // Setup the short form name.
                if match.name.contains("Qualifier") || match.name.contains("Final") {
                    var separatedName = match.name.components(separatedBy: " ")
                    separatedName[1].removeFirst()
                    shortMatchName = String(separatedName[0].first!) + separatedName[1]
                } else if match.name.contains("R"){
                    var separatedName = match.name.components(separatedBy: " ")
                    separatedName[1].removeFirst()
                    shortMatchName = separatedName[0] + " " + separatedName[1]
                } else {
                    var separatedName = match.name.components(separatedBy: " ")
                    separatedName[1].removeFirst()
                    shortMatchName = separatedName[0] + separatedName[1]
                }
            }
            Spacer()
            
            // TODO: Use a better alignment method to allow for more Dynamic Type sizes. Can improve inclusivity.
            VStack {
                ForEach(match.alliances[1].teams) { team in
                    if team.number == self.team.number {
                        Text(team.number)
                            .font(.subheadline)
                            .foregroundStyle(.redAllianceSolid)
                            .underline()
                    } else {
                        Text(team.number)
                            .font(.subheadline)
                            .foregroundStyle(.redAllianceSolid)
                    }
                }
            }
            .frame(width: 70)
            Spacer()

            if let redScore = match.alliances[1].score {
                VStack() {
                    if match.allianceForTeam(id: team.id, side: .team)?.color == "red" {
                        Text(String(redScore))
                            .foregroundStyle(.redAllianceSolid)
                            .underline()
                    } else {
                        Text(String(redScore))
                            .foregroundStyle(.redAllianceSolid)
                    }
                }
                .frame(width: 35)
            }
            Spacer()
            
            if let blueScore = match.alliances[0].score {
                VStack() {
                    if match.allianceForTeam(id: team.id, side: .team)?.color == "blue" {
                        Text(String(blueScore))
                            .foregroundStyle(.blueAllianceSolid)
                            .underline()
                    } else {
                        Text(String(blueScore))
                            .foregroundStyle(.blueAllianceSolid)
                    }
                }
                .frame(width: 35)
            }
            Spacer()

            VStack {
                ForEach(match.alliances[0].teams) { team in
                    if team.number == self.team.number {
                        Text(team.number)
                            .font(.subheadline)
                            .foregroundStyle(.blueAllianceSolid)
                            .underline()
                    } else {
                        Text(team.number)
                            .font(.subheadline)
                            .foregroundStyle(.blueAllianceSolid)
                    }
                }
            }
            .frame(width: 70)
        }
    }
}

#Preview {
    DetailedMatchRow(team: .preview, match: .preview)
}
