//
//  Upcoming.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject var state: StateController
    @State private var matchlist = APIModel()
    @State private var error: ErrorWrapper?

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if error != nil && !matchlist.matches.isEmpty {
                        Section {
                            HStack {
                                Image(systemName: "wifi.exclamationmark")
                                Text("Failed to update matchlist.")
                            }
                        }
                    }
                    Section {
                        ForEach(Array(zip(matchlist.matches.indices, matchlist.matches)), id: \.0) { index, match in
                            NavigationLink {
                                MatchDetails(match: match, isResearch: false).environmentObject(state)
                            } label: {
                                if index < 3 {
                                    LargeMatchRow(match: match)
                                } else {
                                    SmallMatchRow(match: match)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Upcoming")
                .task {
                    do {
                        try await matchlist.fetchMatchlist(state: state)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to update matchlist.")
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

                // Status Feedback
                if matchlist.matches.isEmpty {
                    if matchlist.isLoading {
                        VStack {
                            ProgressView()
                            Text("Fetching matchlist...")
                                .foregroundStyle(.gray)
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
        .environmentObject(StateController())
}
