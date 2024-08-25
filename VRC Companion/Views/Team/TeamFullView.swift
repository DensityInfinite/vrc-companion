//
//  MyTeam.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct TeamFullView: View {
    @EnvironmentObject var state: StateController
    @State private var statsSelection: StatsTypes = .matches
    @State private var error: ErrorWrapper?
    @State private var hasAppeared = false
    
    @State private var apiData = APIModel()
    var title: String
    var teamID: Int

    enum StatsTypes {
        case matches, global, local
    }

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if let teamInfo = apiData.teamInfo, let teamRankings = apiData.rankings {
                        if error != nil {
                            Section {
                                BannerView(systemImage: "wifi.exclamationmark", message: "Failed to update info.", color: .failed)
                                    .environmentObject(state)
                            }
                            .listSectionSpacing(.compact)
                        }
                        
                        Section("Overview", content: {
                            TeamOverviewView(teamInfo: teamInfo, teamRankings: teamRankings)
                        })

                        Section("Details", content: {
                            Picker("Statistics Level", selection: $statsSelection) {
                                Text("Matches").tag(StatsTypes.matches)
                                Text("Local Stats").tag(StatsTypes.local)
                                Text("Global Stats").tag(StatsTypes.global)
                            }
                            .pickerStyle(.segmented)
                            .listRowSeparator(.hidden)

                            switch statsSelection {
                            case .matches:
                                if apiData.isLoading && apiData.matchlist.isEmpty {
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
                            case .local:
                                StatsBoard(rankings: teamRankings, representation: .full)
                                    .padding(.top, -8)
                            case .global:
                                SimpleRow(label: "Grade", details: teamInfo.grade)
                                SimpleRow(label: "Organisation", details: teamInfo.organization)
                                if let robotName = teamInfo.robotName {
                                    SimpleRow(label: "Robot", details: robotName)
                                }
                                SimpleRow(label: "Origin", details: teamInfo.location.city + ", " + teamInfo.location.country)
                            }
                        })
                    }
                }
                .task {
                    do {
                        guard !hasAppeared else { return }
                        try await apiData.fetchTeamInfo(teamID: teamID)
                        try await apiData.fetchRankings(state: state, teamID: teamID)
                        try await apiData.fetchMatchlist(state: state, teamID: teamID)
                        self.error = nil
                        hasAppeared = true
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch info.")
                    }
                }
                .refreshable {
                    do {
                        try await apiData.fetchTeamInfo(teamID: teamID)
                        try await apiData.fetchRankings(state: state, teamID: teamID)
                        try await apiData.fetchMatchlist(state: state, teamID: teamID)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to update info.")
                    }
                }
                .onAppear {
                    if teamID == state.userTeamInfo.id && !hasAppeared {
                        statsSelection = .local
                    }
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(title == "My team" ? .automatic : .inline)
                
                // Status Feedback
                if apiData.teamInfo == nil || apiData.rankings == nil {
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
        private(set) var matchlist: [MatchModel] = []
        private(set) var teamInfo: TeamInfoModel?
        private(set) var rankings: RankingsModel?
        private(set) var isLoading = false

        @MainActor func fetchMatchlist(state: StateController, teamID: Int) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = MatchlistResource(teamID, state.focusedCompetitionID)
            let request = MatchlistRequest(resource: resource)
            matchlist = try await request.execute().matches
        }
        
        @MainActor func fetchTeamInfo(teamID: Int) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = TeamInfoResource(teamID)
            let request = TeamInfoRequest(resource: resource)
            teamInfo = try await request.execute()
        }

        @MainActor func fetchRankings(state: StateController, teamID: Int) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = RankingsResource(teamID, state.focusedCompetitionID)
            let request = RankingsRequest(resource: resource)
            rankings = try await request.execute().rankings.first
        }
    }
}

#Preview {
    TeamFullView(title: "My Team", teamID: StateController().userTeamInfo.id)
        .environmentObject(StateController())
}
