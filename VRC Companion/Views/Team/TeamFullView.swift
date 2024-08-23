//
//  MyTeam.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct TeamFullView: View {
    @EnvironmentObject var state: StateController
    @State private var apiData = APIModel()
    @State private var statsSelection: StatsTypes = .matches
    @State private var error: ErrorWrapper?
    var title: String
    var teamID: Int
    var teamRankings: RankingsModel

    enum StatsTypes {
        case matches, global, local
    }

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if let teamInfo = apiData.teamInfo {
                        if error != nil {
                            Section {
                                HStack {
                                    Image(systemName: "wifi.exclamationmark")
                                    Text("Failed to update info.")
                                }
                            }
                        }
                        
                        Section("Overview", content: {
                            TeamOverviewView(teamInfo: teamInfo, teamRankings: teamRankings)
                        })

                        Section("Details", content: {
                            Picker("Statistics Level", selection: $statsSelection) {
                                Text("Matches").tag(StatsTypes.matches)
                                Text("Global Stats").tag(StatsTypes.global)
                                Text("Local Stats").tag(StatsTypes.local)
                            }
                            .pickerStyle(.segmented)
                            .listRowSeparator(.hidden)

                            switch statsSelection {
                            case .matches:
                                if apiData.isLoading {
                                    HStack {
                                        ProgressView()
                                        Text("Fetching matchlist...")
                                    }
                                }
                                ForEach(apiData.matchlist) { match in
                                    NavigationLink(destination: {
                                        MatchDetails(match: match, isResearch: teamID != state.userTeamInfo.id)
                                    }, label: {
                                        DetailedMatchRow(team: teamInfo, match: match)
                                    })
                                }
                            case .global:
                                Text("Global")
                            case .local:
                                Text("Local")
                            }
                        })
                    }
                }
                .task {
                    do {
                        try await apiData.fetchTeamInfo(teamID: teamID)
                        try await apiData.fetchMatchlist(state: state, teamID: teamID)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to update info.")
                    }
                }
                .animation(.default, value: statsSelection)
                .navigationTitle(title)
                
                // Status Feedback
                if apiData.teamInfo == nil {
                    if apiData.isLoading {
                        VStack {
                            ProgressView()
                            Text("Fetching info...")
                                .foregroundStyle(.gray)
                        }
                    }
                    if let error {
                        ErrorView(error: error)
                    }
                }
            }
        }
    }
}

extension TeamFullView {
    @Observable class APIModel {
        private(set) var teamInfo: TeamInfoModel?
        private(set) var matchlist: [MatchModel] = []
        private(set) var isLoading = false

        @MainActor func fetchTeamInfo(teamID: Int) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = TeamInfoResource(teamID)
            let request = TeamInfoRequest(resource: resource)
            teamInfo = try await request.execute()
        }

        @MainActor func fetchMatchlist(state: StateController, teamID: Int) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = MatchlistResource(teamID, state.focusedCompetitionID)
            let request = MatchlistRequest(resource: resource)
            matchlist = try await request.execute().matches
        }
    }
}

#Preview {
    TeamFullView(title: "My Team", teamID: StateController().userTeamInfo.id, teamRankings: .preview)
        .environmentObject(StateController())
}
