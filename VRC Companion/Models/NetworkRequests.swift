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
    func load(_ url: URL) async throws -> ModelType {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decode(data)
    }
}

class MatchlistRequest {
    let resource: MatchlistResource
    
    init(resource: MatchlistResource) {
        self.resource = resource
    }
}

extension MatchlistRequest: APIRequest {
    func decode(_ data: Data) throws -> MatchlistResource.ModelType {
        return try JSONDecoder.apiDecoder
            .decode(MatchlistModel.self, from: data)
    }
    
    func execute() async throws -> MatchlistResource.ModelType {
        try await load(resource.url)
    }
}

