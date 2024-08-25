//
//  TeamListView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/8/2024.
//

import SwiftUI

struct TeamListView: View {
    @EnvironmentObject var state: StateController
    @State private var searchText: String = ""
    var teamList: EventTeamListModel
    
    var body: some View {
        NavigationStack {
            let filteredList = filter(teamList.teams, for: searchText)
            if filteredList.isEmpty {
                VStack {
                    Spacer()
                    ErrorView(error: ErrorWrapper(error: Errors.noSearchResults, image: "exclamationmark.magnifyingglass", guidance: "No matching teams."))
                }
            }
            List {
                ForEach(filteredList) { team in
                    NavigationLink {
                        TeamFullView(title: team.number, teamID: team.id)
                            .environmentObject(state)
                    } label: {
                        TeamListRow(team: team)
                        if team.id == state.userTeamInfo.id {
                            Text("(You)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Teams...")
            .navigationTitle("All teams")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension TeamListView {
    func filter(_ teams: [TeamInfoModel], for searchText: String) -> [TeamInfoModel] {
        guard !searchText.isEmpty else { return teams }
        return teams.filter { team in
            team.number.lowercased().contains(searchText.lowercased()) ||
            team.name.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    TeamListView(teamList: .preview)
        .environmentObject(StateController())
}
