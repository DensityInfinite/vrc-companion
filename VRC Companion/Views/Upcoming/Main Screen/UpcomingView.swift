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
                List{
                    ForEach(Array(zip(matchlist.matches.indices, matchlist.matches)), id: \.0) { index, match in
                        NavigationLink {
                            MatchDetails(match: match).environmentObject(state)
                        } label: {
                            if index < 3 {
                                LargeMatchRow(match: match)
                            } else {
                                SmallMatchRow(match: match)
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
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "API request failed.")
                    }
                }
                .refreshable {
                    do {
                        try await matchlist.fetchMatchlist(state: state)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "API request failed.")
                    }
                }
                
                // Status Feedback
                if matchlist.isLoading && matchlist.matches.isEmpty {
                    VStack {
                        ProgressView()
                        Text("Fetching matchlist...")
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

extension UpcomingView {
    @Observable class APIModel {
        private(set) var matches: [MatchModel] = []
        private(set) var isLoading = false

        @MainActor func fetchMatchlist(state: StateController) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = MatchlistResource(state.userAllianceTeam.id, state.focusedCompetitionID)
            let request = MatchlistRequest(resource: resource)
            matches = try await request.execute().matches
        }
    }
}

#Preview {
    UpcomingView()
        .environmentObject(StateController())
}
