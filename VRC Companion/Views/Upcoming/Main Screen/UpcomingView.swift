//
//  Upcoming.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct UpcomingView: View {
    @Environment(StateController.self) var state
    @State private var matchlist = APIModel()
    @State private var error: ErrorWrapper?
    @State private var hasAppeared = false
    
    @State private var isSearchPresented: Bool = false
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            let filteredMatches = filter(matchlist.matches, for: searchText)
            ZStack {
                List {
                    if error != nil && !matchlist.matches.isEmpty {
                        Section {
                            BannerView(systemImage: "wifi.exclamationmark", message: "Failed to update matchlist.", color: .failed)
                                .environment(state)
                        }
                        .listSectionSpacing(.compact)
                    }
                    Section {
                        if !isSearchPresented {
                            ForEach(Array(zip(matchlist.matches.indices, matchlist.matches)), id: \.0) { index, match in
                                NavigationLink {
                                    MatchDetails(match: match, isResearch: false).environment(state)
                                } label: {
                                    if index < 3 {
                                        LargeMatchRow(match: match)
                                    } else {
                                        SmallMatchRow(match: match)
                                    }
                                }
                            }
                        } else {
                            ForEach(Array(zip(filteredMatches.indices, filteredMatches)), id: \.0) { index, match in
                                NavigationLink {
                                    MatchDetails(match: match, isResearch: false).environment(state)
                                } label: {
                                    if index < 2 {
                                        LargeMatchRow(match: match, presentingWLT: false)
                                    } else {
                                        SmallMatchRow(match: match)
                                    }
                                }
                            }
                        }
                    }
                }
                .task {
                    do {
                        guard !hasAppeared else { return }
                        try await matchlist.fetchMatchlist(state: state)
                        self.error = nil
                        hasAppeared = true
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch matchlist.")
                    }
                }
                .refreshable {
                    do {
                        try await matchlist.fetchMatchlist(state: state)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to update matchlist.")
                    }
                }
                .searchable(text: $searchText, isPresented: $isSearchPresented, prompt: "Matches and teams...")
                .navigationTitle("Upcoming")

                // Status Feedback
                if matchlist.matches.isEmpty {
                    if matchlist.isLoading {
                        VStack {
                            ProgressView()
                            Text("Fetching matchlist...")
                                .foregroundStyle(.secondary)
                        }
                    }
                    if let error {
                        ErrorView(error: error)
                            .containerRelativeFrame(.horizontal, alignment: .center)
                    }
                }
            }
        }
    }
}

extension UpcomingView {
    func filter(_ matchlist: [MatchModel], for searchText: String) -> [MatchModel] {
        guard !searchText.isEmpty else { return matchlist }
        let searchText = searchText.lowercased()
        return matchlist.filter { match in
            match.name.lowercased().contains(searchText) ||
            match.alliances[0].teams[0].number.lowercased().contains(searchText) ||
            match.alliances[0].teams[1].number.lowercased().contains(searchText) ||
            match.alliances[1].teams[0].number.lowercased().contains(searchText) ||
            match.alliances[1].teams[1].number.lowercased().contains(searchText)
        }
    }
}

extension UpcomingView {
    @Observable class APIModel {
        private(set) var matches: [MatchModel] = []
        private(set) var isLoading = false

        @MainActor func fetchMatchlist(state: StateController) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = MatchlistResource(state.userTeamInfo.id, state.focusedCompetitionID)
            let request = MatchlistRequest(resource: resource)
            matches = try await request.execute().matches
        }
    }
}

#Preview {
    UpcomingView()
        .environment(StateController())
}
