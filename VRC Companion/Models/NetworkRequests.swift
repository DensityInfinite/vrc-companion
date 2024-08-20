//
//  Networking.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 21/8/2024.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) throws -> ModelType
    func execute() async throws -> ModelType
}

extension NetworkRequest {
    func load(_ url: URL) async throws -> ModelType {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decode(data)
    }
}

class MatchlistRequest {
    let resource: MatchlistResource
    
    init(resource: MatchlistResource) {
        self.resource = resource
    }
}

extension MatchlistRequest: NetworkRequest {
    func decode(_ data: Data) throws -> MatchlistRequest.ModelType {
        return try JSONDecoder.apiDecoder
            .decode(MatchlistModel.self, from: data)

    }
    
    func execute() async throws -> MatchlistResource.ModelType {
        try await load(resource.url)
    }
}

