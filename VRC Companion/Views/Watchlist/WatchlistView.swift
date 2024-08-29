//
//  Watchlist.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftData
import SwiftUI

struct WatchlistView: View {
    @Environment(StateController.self) var state

    /// The model context provided by the SwiftData container, allows manipulation of persisted data.
    @Environment(\.modelContext) private var context

    /// The persisted watchlist from storage.
    @Query(sort: \TeamInfoModel.number) private var watchlist: [TeamInfoModel]

    @State private var isSearchPresented: Bool = false
    @State private var searchText: String = ""

    @State private var error: ErrorWrapper?
    @State private var apiData: [APIModel] = []

    var body: some View {
        NavigationStack {
            var filteredData = filter(apiData, for: searchText)
            if filteredData.isEmpty && isSearchPresented {
                VStack {
                    Spacer()
                    ErrorView(error: ErrorWrapper(error: Errors.noSearchResults, image: "exclamationmark.magnifyingglass", guidance: "No matching teams."))
                }
            }
            ZStack {
                List {
                    if let error {
                        if !isSearchPresented {
                            Section {
                                BannerView(systemImage: error.image, message: error.guidance, color: .failed)
                                    .environment(state)
                            }
                            .listSectionSpacing(.compact)
                        }
                    }

                    Section {
                        if apiData.isEmpty {
                            ForEach(watchlist) { team in
                                HStack {
                                    Text(team.number)
                                    Spacer()
                                    Text(team.name)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .onDelete(perform: { indexSet in
                                for index in indexSet {
                                    let team = watchlist[index]
                                    context.delete(team)
                                }
                            })
                        } else {
                            ForEach(filteredData) { data in
                                NavigationLink {
                                    TeamFullView(title: data.associatedTeam.number, teamID: data.associatedTeam.id)
                                } label: {
                                    if let rankings = data.rankings {
                                        WatchlistTeamRow(team: data.associatedTeam, rankings: rankings, presentingBoard: !isSearchPresented)
                                    } else {
                                        HStack {
                                            Text(data.associatedTeam.number)
                                            Spacer()
                                            Text(data.associatedTeam.name)
                                                .foregroundStyle(.secondary)
                                            if data.isLoading {
                                                ProgressView()
                                            }
                                        }
                                    }
                                }
                            }
                            .onDelete(perform: { indexSet in
                                for index in indexSet {
                                    let filterData = filteredData[index]
                                    for (index, data) in apiData.enumerated() where data.associatedTeam.id == filterData.associatedTeam.id {
                                        apiData.remove(at: index)
                                    }
                                    filteredData.remove(at: index)
                                    for team in watchlist where team.id == filterData.associatedTeam.id {
                                        context.delete(team)
                                    }
                                }
                            })
                        }
                    }
                }
                .task {
                    do {
                        try await refreshAPIData(with: watchlist)
                        error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch stats.")
                    }
                }
                .refreshable {
                    do {
                        try await refreshAPIData(with: watchlist)
                        error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch stats.")
                    }
                }
                .searchable(text: $searchText, isPresented: $isSearchPresented, prompt: "Teams...")
                .navigationTitle("Watchlist")

                // Empty prompt
                if watchlist.isEmpty {
                    VStack {
                        Image(systemName: "star")
                            .font(.title)
                            .imageScale(.large)
                            .foregroundStyle(.secondary)
                        Text("Your Watchlist is Empty")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text("Watch teams for quick access to their statistics.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

extension WatchlistView {
    /// Updates and syncs the API data array property with the given watchlist.
    func refreshAPIData(with watchlist: [TeamInfoModel]) async throws {
        // TODO: Currently this has high energy impact. Consider optimisation in the future.

        // Adds API data for newly-watched teams
        for team in watchlist {
            if !apiData.contains(where: { $0.associatedTeam.id == team.id }) {
                apiData.append(APIModel(associatedTeam: team))
            }
        }

        // Removes API data for teams that were recently unwatched
        apiData.removeAll { data in
            !watchlist.contains(where: { $0.id == data.associatedTeam.id })
        }

        for data in apiData {
            try await data.fetchRankings(state: state)
        }

        // Sorts the API data array using the rank so it matches the order of the persisted team array
        apiData.sort {
            if let rank0 = $0.rankings?.rank, let rank1 = $1.rankings?.rank {
                return rank0 < rank1
            }
            return false
        }
    }

    /// Returns a filtered team list using the provided search text.
    ///
    /// This method matches the search text with each given team's number and name.
    func filter(_ data: [APIModel], for searchText: String) -> [APIModel] {
        guard !searchText.isEmpty else { return data }
        return data.filter { data in
            data.associatedTeam.number.lowercased().contains(searchText.lowercased()) ||
                data.associatedTeam.name.lowercased().contains(searchText.lowercased())
        }
    }
}

extension WatchlistView {
    @Observable class APIModel: Identifiable {
        var id = UUID()
        var associatedTeam: TeamInfoModel
        private(set) var rankings: RankingsModel?
        private(set) var isLoading = false

        @MainActor func fetchRankings(state: StateController) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = RankingsResource(associatedTeam.id, state.focusedCompetitionID)
            let request = RankingsRequest(resource: resource)
            rankings = try await request.execute().rankings.first
        }

        init(associatedTeam: TeamInfoModel) {
            self.associatedTeam = associatedTeam
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
        return WatchlistView()
            .environment(StateController())
            .modelContainer(container)
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}
