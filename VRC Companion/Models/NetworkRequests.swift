//
//  Networking.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 21/8/2024.
//

import Foundation

protocol APIRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) throws -> ModelType
    func execute() async throws -> ModelType
}

extension APIRequest {
    /// Pulls and decodes the data from the given url endpoint.
    func load(_ url: URL) async throws -> ModelType {
        // let token = <add your token here>
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decode(data)
    }
}

// TODO: A generic type can be created to reduce duplicated code here.

class MatchlistRequest {
    let resource: MatchlistResource

    init(resource: MatchlistResource) {
        self.resource = resource
    }
}

extension MatchlistRequest: APIRequest {
    func decode(_ data: Data) throws -> MatchlistResource.ModelType {
        return try JSONDecoder.apiDecoder
            .decode(MatchlistResource.ModelType.self, from: data)
    }

    func execute() async throws -> MatchlistResource.ModelType {
        try await load(resource.url)
    }
}

class RankingsRequest {
    let resource: RankingsResource

    init(resource: RankingsResource) {
        self.resource = resource
    }
}

extension RankingsRequest: APIRequest {
    func decode(_ data: Data) throws -> RankingsResource.ModelType {
        return try JSONDecoder.apiDecoder
            .decode(RankingsResource.ModelType.self, from: data)
    }

    func execute() async throws -> RankingsResource.ModelType {
        try await load(resource.url)
    }
}

class EventTeamListRequest {
    let resource: EventTeamListResource
    
    init(resource: EventTeamListResource) {
        self.resource = resource
    }
}

extension EventTeamListRequest: APIRequest {
    func decode(_ data: Data) throws -> EventTeamListResource.ModelType {
        return try JSONDecoder.apiDecoder
            .decode(EventTeamListResource.ModelType.self, from: data)
    }
    
    func execute() async throws -> EventTeamListResource.ModelType {
        try await load(resource.url)
    }
}

class TeamInfoRequest {
    let resource: TeamInfoResource
    
    init(resource: TeamInfoResource) {
        self.resource = resource
    }
}

extension TeamInfoRequest: APIRequest {
    func decode(_ data: Data) throws -> TeamInfoResource.ModelType {
        return try JSONDecoder.apiDecoder
            .decode(TeamInfoResource.ModelType.self, from: data)
    }
    
    func execute() async throws -> TeamInfoResource.ModelType {
        try await load(resource.url)
    }
}

class EventInfoRequest {
    let resource: EventInfoResource
    
    init(resource: EventInfoResource) {
        self.resource = resource
    }
}

extension EventInfoRequest: APIRequest {
    func decode(_ data: Data) throws -> EventInfoResource.ModelType {
        return try JSONDecoder.apiDecoder
            .decode(EventInfoResource.ModelType.self, from: data)
    }
    
    func execute() async throws -> EventInfoResource.ModelType {
        try await load(resource.url)
    }
}
