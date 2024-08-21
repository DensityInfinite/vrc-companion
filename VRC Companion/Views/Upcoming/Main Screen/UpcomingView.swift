//
//  Upcoming.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject var state: StateController
    @State private var matchlist = Model()
    @State private var error: ErrorWrapper?

    var body: some View {
        NavigationStack {
            ZStack {
                List(matchlist.matches, id: \.id, rowContent: { match in
                    NavigationLink {
                        MatchDetails(match: match).environmentObject(state)
                    } label: {
                        LargeMatchRow(match: match)
                    }
                })
                .navigationTitle("Upcoming")
                .task {
                    do {
                        try await matchlist.fetchMatchlist()
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "API request failed.")
                    }
                }
                .refreshable {
                    try? await matchlist.fetchMatchlist()
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
    @Observable class Model {
        private(set) var matches: [MatchModel] = []
        private(set) var isLoading = false

        @MainActor func fetchMatchlist() async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = MatchlistResource(StateController().userTeam.id)
            let request = MatchlistRequest(resource: resource)
            matches = try await request.execute().matches
        }
    }
}

#Preview {
    UpcomingView()
        .environmentObject(StateController())
}
