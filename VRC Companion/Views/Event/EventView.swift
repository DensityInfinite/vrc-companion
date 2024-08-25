//
//  Event.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct EventView: View {
    @EnvironmentObject var state: StateController
    @State private var eventInfo = APIModel()
    @State private var error: ErrorWrapper?
    @State private var hasAppeared = false

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    if error != nil && eventInfo.info != nil {
                        Section {
                            BannerView(systemImage: "wifi.exclamationmark", message: "Failed to update info.", color: .failed)
                                .environmentObject(state)
                        }
                        .listSectionSpacing(.compact)
                    }
                    if let eventInfo = eventInfo.info {
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
                            NavigationLink {
                                TeamListView(teamList: .preview)
                                    .environmentObject(state)
                            } label: {
                                Text("All Teams")
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
                        try await eventInfo.fetchInfo(state: state)
                        self.error = nil
                        hasAppeared = true
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch info.")
                    }
                }
                .refreshable {
                    do {
                        try await eventInfo.fetchInfo(state: state)
                        self.error = nil
                    } catch {
                        self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to update info.")
                    }
                }

                // Status Feedback
                if eventInfo.info == nil {
                    if eventInfo.isLoading {
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
        private(set) var isLoading = false

        @MainActor func fetchInfo(state: StateController) async throws {
            guard !isLoading else { return }
            defer { isLoading = false }
            isLoading = true
            let resource = EventInfoResource(state.focusedCompetitionID ?? -1)
            let request = EventInfoRequest(resource: resource)
            info = try await request.execute()
        }
    }
}

#Preview {
    EventView()
        .environmentObject(StateController())
}
