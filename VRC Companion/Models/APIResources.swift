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
    var eventID: String? { get }
}

extension APIResource {
    var url: URL {
        let url = URL(string: "https://www.robotevents.com/api/v2")!
            .appendingPathComponent(methodPath)
        guard let eventID else { return url }
        return url.appending(queryItems: [URLQueryItem(name: "event[]", value: eventID)])
    }
}
