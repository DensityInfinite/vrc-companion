//
//  APIResource.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/7/2024.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var eventID: Int? { get }
}

extension APIResource {
    var url: URL {
        let url = URL(string: "https://www.robotevents.com/api/v2")!
            .appendingPathComponent(methodPath)
        guard let eventID else { return url }
        return url.appending(queryItems: [URLQueryItem(name: "event[]", value: String(eventID))])
    }
}

struct MatchlistResource: APIResource {
    var teamID: Int
    
    typealias ModelType = MatchlistModel
    var methodPath: String
    var eventID: Int?
    
    init(_ teamID: Int, _ eventID: Int? = nil) {
        self.teamID = teamID
        methodPath = "/teams/\(teamID)/matches"
        self.eventID = eventID
    }
}
