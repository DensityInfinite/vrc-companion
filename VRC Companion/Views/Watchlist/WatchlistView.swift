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
    @Environment(\.modelContext) private var context
    @Query(sort: \TeamInfoModel.number) private var watchlist: [TeamInfoModel]
    
    @State private var isSearchPresented: Bool = false
    @State private var searchText: String = ""

    @State private var error: ErrorWrapper?
    @State private var apiData: [APIModel] = []

    var body: some View {
        NavigationStack {
            let filteredData = filter(apiData, for: searchText)
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
                                    let team = watchlist[index]
                                    context.delete(team)
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
    func refreshAPIData(with watchlist: [TeamInfoModel]) async throws {
        // Currently this has high energy impact. Consider optimisation in the future.
        for team in watchlist {
            if !apiData.contains(where: { $0.associatedTeam.id == team.id }) {
                apiData.append(APIModel(associatedTeam: team))
            }
        }

        apiData.removeAll { data in
            !watchlist.contains(where: { $0.id == data.associatedTeam.id })
        }

        for data in apiData {
            try await data.fetchRankings(state: state)
        }

        apiData.sort {
            if let rank0 = $0.rankings?.rank, let rank1 = $1.rankings?.rank {
                return rank0 < rank1
            }
            return false
        }
    }

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
