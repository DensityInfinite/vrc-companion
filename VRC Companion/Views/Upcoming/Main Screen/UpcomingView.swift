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

    @State private var isSplashScreenPresented: Bool = false

    var body: some View {
        NavigationStack {
            let filteredMatches = filter(matchlist.matches, for: searchText)

            // Provides a prompt to the user when their search has no results
            if filteredMatches.isEmpty && isSearchPresented {
                VStack {
                    Spacer()
                    ErrorView(error: ErrorWrapper(error: Errors.noSearchResults, image: "exclamationmark.magnifyingglass", guidance: "No matches."))
                }
            }

            ZStack {
                List {
                    if error != nil && !matchlist.matches.isEmpty && !isSearchPresented {
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
                                    if index < 3 { // First 3 rows will use a Large presentation because these are the primary focus of the user
                                        LargeMatchRow(match: match)
                                    } else { // The rest uses a minimal appearance to save space and API pulls.
                                        SmallMatchRow(match: match)
                                    }
                                }
                            }
                        } else {
                            ForEach(Array(zip(filteredMatches.indices, filteredMatches)), id: \.0) { index, match in
                                NavigationLink {
                                    MatchDetails(match: match, isResearch: false).environment(state)
                                } label: {
                                    if index < 2 { // First 2 rows (instead of 3) is enlarged here to allow space for displaying more matches beneath it.
                                        LargeMatchRow(match: match, presentingWLT: false)
                                    } else {
                                        SmallMatchRow(match: match) // Although not displayed here, teams in those matches remain searchable.
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
                .onAppear(perform: checkForNewInstall)
                .searchable(text: $searchText, isPresented: $isSearchPresented, prompt: "Matches and teams...")
                .sheet(isPresented: $isSplashScreenPresented) {
                    SplashScreen()
                }
                .navigationTitle("Upcoming")

                // Feedback to the user about the loading status, when no content has already been pulled.
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
    /// Returns a filtered matchlist using the provided search text.
    ///
    /// This method matches the search text with:
    /// 1. Each given match name.
    /// 2. The team numbers of all teams attending each given match.
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

    /// Detects a fresh install of the application and (if yes) presents the welcome splash screen.
    func checkForNewInstall() {
        let isOldInstall = UserDefaults.standard.bool(forKey: "oldInstall")

        if !isOldInstall {
            isSplashScreenPresented.toggle()
            UserDefaults.standard.set(true, forKey: "oldInstall")
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
