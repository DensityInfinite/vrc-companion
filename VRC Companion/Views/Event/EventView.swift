//
//  Event.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct EventView: View {
    @Environment(StateController.self) var state
    @State private var apiData = APIModel()
    @State private var error: ErrorWrapper?
    @State private var hasAppeared = false

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if error != nil && (apiData.info != nil || !apiData.teamList.isEmpty) {
                        Section {
                            BannerView(systemImage: "wifi.exclamationmark", message: "Failed to update info.", color: .failed)
                                .environment(state)
                        }
                        .listSectionSpacing(.compact)
                    }
                    
                    if let eventInfo = apiData.info {
                        Section("Skills") {
                            NavigationLink {
                                DemoView(title: "Event skills", titleStyle: .inline)
                            } label: {
                                Text("Local Rankings")
                            }
                        }

                        Section("Divisions") {
                            ForEach(eventInfo.divisions) { division in
                                NavigationLink {
                                    DemoView(title: division.name, titleStyle: .inline)
                                } label: {
                                    Text(division.name.contains("Default") ? "Default" : division.name)
                                }
                            }
                        }

                        Section("About") {
                            if apiData.isLoading && apiData.teamList.isEmpty {
                                HStack {
                                    Text("All Teams")
                                    Spacer()
                                    ProgressView()
                                }
                            } else if !apiData.teamList.isEmpty {
                                NavigationLink {
                                    TeamListView(teamList: apiData.teamList)
                                        .environment(state)
                                } label: {
                                    Text("All Teams")
                                }
                            } else {
                                HStack {
                                    Text("All Teams")
                                    Spacer()
                                    Image(systemName: "wifi.exclamationmark")
                                        .foregroundStyle(.secondary)
                                }
                            }

                            NavigationLink {
                                EventAboutView(eventInfo: eventInfo)
                            } label: {
                                Text("About this Event")
                            }
                        }
                    }
                }
                .navigationTitle("Event")
                .task {
                    do {
                        guard !hasAppeared else { return }
                        try await apiData.fetchEventInfo(state: state)
                        try await apiData.fetchTeamList(state: state)
                        self.error = nil
                        hasAppeared = true
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch info.")
                    }
                }
                .refreshable {
                    do {
                        try await apiData.fetchEventInfo(state: state)
                        try await apiData.fetchTeamList(state: state)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to update info.")
                    }
                }

                // Feedback to the user about the loading status, when no content has already been pulled.
                if apiData.info == nil {
                    if apiData.isLoading {
                        VStack {
                            ProgressView()
                            Text("Fetching info...")
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

extension EventView {
    @Observable class APIModel {
        private(set) var info: EventInfoModel?
        private(set) var teamList: [TeamInfoModel] = []
        private(set) var isLoading = false

        @MainActor func fetchEventInfo(state: StateController) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = EventInfoResource(state.focusedCompetitionID ?? -1)
            let request = EventInfoRequest(resource: resource)
            info = try await request.execute()
        }

        @MainActor func fetchTeamList(state: StateController) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            var resource = EventTeamListResource(state.focusedCompetitionID ?? -1)
            var request = EventTeamListRequest(resource: resource)

            var apiData = try await request.execute()
            teamList.append(contentsOf: apiData.teams)

            // Team list can span multiple pages, so we recursively retrieve teams in all pages
            while let nextPageURL = apiData.meta.nextPageURL?.absoluteString {
                resource.updateToPagedURL(for: nextPageURL, in: state.focusedCompetitionID ?? -1)
                request = EventTeamListRequest(resource: resource)
                apiData = try await request.execute()
                teamList.append(contentsOf: apiData.teams)
            }
        }
    }
}

#Preview {
    EventView()
        .environment(StateController())
}
