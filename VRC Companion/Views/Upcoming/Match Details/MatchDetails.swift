//
//  MatchDetails.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 23/2/2024.
//

import SwiftUI

struct MatchDetails: View {
    @Environment(StateController.self) var state
    @State private var opponentTopData = APIModel()
    @State private var opponentBottomData = APIModel()
    @State private var presentTeam1Sheet: Bool = false
    @State private var presentTeam2Sheet: Bool = false
    @State private var presentTeam3Sheet: Bool = false
    @State private var presentTeam4Sheet: Bool = false
    @State private var error: ErrorWrapper?
    @State private var hasAppeared: Bool = false
    var match: MatchModel
    
    /// Whether this view is presented under a research context, i.e. unrelated to the user team.
    var isResearch: Bool

    var body: some View {
        NavigationStack {
            List {
                Section {
                    AtAGlanceView(match: match, isResearch: isResearch)
                        .environment(state)
                        .padding(.top, -8)
                        .padding(.bottom, -8)
                }

                Section {
                    BannerView(match: match)
                        .environment(state)
                }
                .listSectionSpacing(.compact)

                if error != nil {
                    Section {
                        BannerView(systemImage: "wifi.exclamationmark", message: "Failed to update info.", color: .failed)
                            .environment(state)
                    }
                    .listSectionSpacing(.compact)
                }

                if isResearch {
                    Section("Red Alliance") {
                        SmallTeamRow(team: match.alliances[1].teams[0])
                        SmallTeamRow(team: match.alliances[1].teams[1])
                    }

                    Section("Blue Alliance") {
                        SmallTeamRow(team: match.alliances[0].teams[0])
                        SmallTeamRow(team: match.alliances[0].teams[1])
                    }
                } else {
                    // Presents the opposing teams using more detailed LargeTeamRow views.
                    if let opposingAlliance = match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition) {
                        Section("Opponents - \(opposingAlliance.color.capitalized) Alliance") {
                            if opponentTopData.isLoading && opponentTopData.rankings == nil {
                                HStack {
                                    SmallTeamRow(team: opposingAlliance.teams[0])
                                    ProgressView()
                                }
                            } else if let rankings = opponentTopData.rankings {
                                LargeTeamRow(team: opposingAlliance.teams[0], rankings: rankings, presentingSheet: $presentTeam1Sheet)
                            } else {
                                HStack {
                                    SmallTeamRow(team: opposingAlliance.teams[0])
                                    Button(action: {
                                        presentTeam1Sheet.toggle()
                                    }, label: {
                                        Label("Lookup this team", systemImage: "magnifyingglass")
                                            .labelStyle(.iconOnly)
                                    })
                                }
                            }
                            if (opponentBottomData.isLoading || opponentTopData.isLoading) && opponentBottomData.rankings == nil {
                                HStack {
                                    SmallTeamRow(team: opposingAlliance.teams[1])
                                    ProgressView()
                                }
                            } else if let rankings = opponentBottomData.rankings {
                                LargeTeamRow(team: opposingAlliance.teams[1], rankings: rankings, presentingSheet: $presentTeam2Sheet)
                            } else {
                                HStack {
                                    SmallTeamRow(team: opposingAlliance.teams[1])
                                    Button(action: {
                                        presentTeam2Sheet.toggle()
                                    }, label: {
                                        Label("Lookup this team", systemImage: "magnifyingglass")
                                            .labelStyle(.iconOnly)
                                    })
                                }
                            }
                        }
                    }

                    if let teamAlliance = match.allianceForTeam(id: state.userTeamInfo.id, side: .team) {
                        Section("Your Alliance") {
                            HStack {
                                SmallTeamRow(team: teamAlliance.teams[0])
                                Button(action: {
                                    presentTeam3Sheet.toggle()
                                }, label: {
                                    Label("Lookup this team", systemImage: "magnifyingglass")
                                        .labelStyle(.iconOnly)
                                })
                            }
                            HStack {
                                SmallTeamRow(team: teamAlliance.teams[1])
                                Button(action: {
                                    presentTeam4Sheet.toggle()
                                }, label: {
                                    Label("Lookup this team", systemImage: "magnifyingglass")
                                        .labelStyle(.iconOnly)
                                })
                            }
                        }
                    }
                }
            }
            .task {
                do {
                    if !hasAppeared || opponentTopData.rankings == nil || opponentBottomData.rankings == nil {
                        if let alliance = match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition) {
                            try await opponentTopData.fetchRankings(state: state, teamID: alliance.teams[0].id)
                            try await opponentBottomData.fetchRankings(state: state, teamID: alliance.teams[1].id)
                        }
                        hasAppeared = true
                        self.error = nil
                    } else {
                        return
                    }
                } catch {
                    self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch info.")
                }
            }
            .refreshable {
                do {
                    if let alliance = match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition) {
                        try await opponentTopData.fetchRankings(state: state, teamID: alliance.teams[0].id)
                        try await opponentBottomData.fetchRankings(state: state, teamID: alliance.teams[1].id)
                    }
                    self.error = nil
                } catch {
                    self.error = ErrorWrapper(error: Errors.apiError, image: "wifi.exclamationmark", guidance: "Failed to fetch info.")
                }
            }
            // TODO: Need to also allow sheet presentation under a research context.
            // TODO: Lots of refactoring potential for a more efficient way of presenting these sheets.
            .sheet(isPresented: $presentTeam1Sheet, content: {
                ZStack {
                    if let team = match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)?.teams[0] {
                        TeamFullView(title: team.number, teamID: team.id)
                    }
                    VStack {
                        Grabber()
                        Spacer()
                    }
                }
            })
            .sheet(isPresented: $presentTeam2Sheet, content: {
                ZStack {
                    if let team = match.allianceForTeam(id: state.userTeamInfo.id, side: .opposition)?.teams[1] {
                        TeamFullView(title: team.number, teamID: team.id)
                    }
                    VStack {
                        Grabber()
                        Spacer()
                    }
                }
            })
            .sheet(isPresented: $presentTeam3Sheet, content: {
                ZStack {
                    if let team = match.allianceForTeam(id: state.userTeamInfo.id, side: .team)?.teams[0] {
                        TeamFullView(title: team.number, teamID: team.id)
                    }
                    VStack {
                        Grabber()
                        Spacer()
                    }
                }
            })
            .sheet(isPresented: $presentTeam4Sheet, content: {
                ZStack {
                    if let team = match.allianceForTeam(id: state.userTeamInfo.id, side: .team)?.teams[1] {
                        TeamFullView(title: team.number, teamID: team.id)
                    }
                    VStack {
                        Grabber()
                        Spacer()
                    }
                }
            })
            .navigationTitle(match.name)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, -30)
        }
    }
}

extension MatchDetails {
    @Observable class APIModel {
        private(set) var rankings: RankingsModel?
        private(set) var isLoading = false

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
    MatchDetails(match: .preview, isResearch: false)
        .environment(StateController())
}
