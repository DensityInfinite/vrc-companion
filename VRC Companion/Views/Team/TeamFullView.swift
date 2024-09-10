//
//  MyTeam.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI
import SwiftData

struct TeamFullView: View {
    @Environment(StateController.self) var state
    
    /// The model context provided by the SwiftData container, allows manipulation of persisted data.
    @Environment(\.modelContext) private var context
    
    /// The persisted watchlist from storage.
    @Query private var watchlist: [TeamInfoModel]
    
    /// The current selected tile on the details segmented control.
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
                                    .environment(state)
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

                            // Conditionally present views based on the selected tile
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
                                StatsBoard(rankings: teamRankings, appearance: .full)
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
                        
                        // This view's APIModel class methods creates a new TeamInfoModel object with every API pull.
                        // SwiftData regards this newly-pulled object as a unique one, consequently it can't be used to locate an existing entry
                        // in the persisted watchlist.
                        // Additionally, if this new object is saved, there can potentially be some virtually duplicated entries in the matchlist.
                        // The workaround I have found is the following, to remove the existing object and insert the new one with every API pull.
                        // I think this is a bit cursed, but I could not find a better way myself. If you have an elegant solution to this, feel free to open a PR.
                        if let apiTeam = apiData.teamInfo {
                            for team in watchlist {
                                if team.id == apiTeam.id && team != apiTeam {
                                    context.delete(team)
                                    context.insert(apiTeam)
                                }
                            }
                        }
                        
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
                        
                        // Same reason as above.
                        if let apiTeam = apiData.teamInfo {
                            for team in watchlist {
                                if team.id == apiTeam.id && team != apiTeam {
                                    context.delete(team)
                                    context.insert(apiTeam)
                                }
                            }
                        }
                        
                        try await apiData.fetchRankings(state: state, teamID: teamID)
                        try await apiData.fetchMatchlist(state: state, teamID: teamID)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to update info.")
                    }
                }
                .onAppear {
                    // The user usually knows their own matchlist very well for a number of good reasons. Displaying their own matchlist here is redundant.
                    // Therfore, if the requrested teamID matches that of the user's (such as when this view is displayed in the "My team" tab),
                    // this view proritises presenting the user their own local stats, which is the thing they usually care more about.
                    if teamID == state.userTeamInfo.id && !hasAppeared {
                        statsSelection = .local
                    }
                }
                .toolbar {
                    if let teamInfo = apiData.teamInfo {
                        ToolbarItem {
                            Button(action: {
                                if watchlist.contains(teamInfo) {
                                    context.delete(teamInfo)
                                } else {
                                    context.insert(teamInfo)
                                }
                            }, label: {
                                Label(watchlist.contains(teamInfo) ? "Unwatch team" : "Watch team", systemImage: watchlist.contains(teamInfo) ? "star.fill" : "star")
                            })
                        }
                    }
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(title == "You" ? .automatic : .inline)
                
                // Feedback to the user about the loading status, when no content has already been pulled.
                if apiData.teamInfo == nil || apiData.rankings == nil {
                    if apiData.isLoading {
                        VStack {
                            ProgressView()
                            Text("Fetching info...")
                                .foregroundStyle(.secondary)
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
        var teamInfo: TeamInfoModel?
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
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema([
            TeamInfoModel.self,
            LocationModel.self,
            IDInfoModel.self
        ])
        let container = try ModelContainer(for: schema, configurations: config)
        return TeamFullView(title: "My team", teamID: StateController().userTeamInfo.id)
            .environment(StateController())
            .modelContainer(container)
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}
