//
//  APIResources.swift
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

protocol Paginated: APIResource {
    var page: Int? { get }
}

extension Paginated {
    var url: URL {
        var url = URL(string: "https://www.robotevents.com/api/v2")!
            .appendingPathComponent(methodPath)
        if let eventID {
            url = url.appending(queryItems: [URLQueryItem(name: "event[]", value: String(eventID))])
        }
        if let page {
            url = url.appending(queryItems: [URLQueryItem(name: "page", value: String(page))])
        }
        return url
    }
}

struct MatchlistResource: APIResource {
    typealias ModelType = MatchlistModel
    var methodPath: String
    var eventID: Int?
    
    init(_ teamID: Int, _ eventID: Int? = nil) {
        methodPath = "/teams/\(teamID)/matches"
        self.eventID = eventID
    }
}

struct RankingsResource: APIResource {
    typealias ModelType = APIRankingsModel
    var methodPath: String
    var eventID: Int?
    
    init(_ teamID: Int, _ eventID: Int? = nil) {
        methodPath = "/teams/\(teamID)/rankings"
        self.eventID = eventID
    }
}

struct EventTeamListResource: APIResource, Paginated {
    typealias ModelType = EventTeamListModel
    var methodPath: String
    var eventID: Int?
    var page: Int?
    
    init(_ eventID: Int) {
        methodPath = "/events/\(eventID)/teams"
    }
    
    /// Updates the page property to allow for the pulling of another page for the same API endpoint.
    mutating func updateToPagedURL(for pageURL: String, in eventID: Int) {
        page = Int(pageURL.components(separatedBy: "?").last?.components(separatedBy: "=").last ?? "1")
    }
}

struct TeamInfoResource: APIResource {
    typealias ModelType = TeamInfoModel
    var methodPath: String
    var eventID: Int?
    
    init(_ teamID: Int) {
        methodPath = "/teams/\(teamID)"
    }
}

struct EventInfoResource: APIResource {
    typealias ModelType = EventInfoModel
    var methodPath: String
    var eventID: Int?
    
    init(_ eventID: Int) {
        methodPath = "/events/\(eventID)"
    }
}
