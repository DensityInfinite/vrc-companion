//
//  RobotEventsMeta.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 22/6/2024.
//

import Foundation

struct Meta {
    let currentPage: Int
    let source: URL
    
    let lastPage: Int
    let lastPageURL: URL?
    
    let firstPageURL: URL
    let prevPageURL: URL?
    let nextPageURL: URL?
    
    let entriesPerPage: Int
    let fromEntry: Int
    let toEntry: Int
    let totalEntries: Int
}

extension Meta: Decodable {
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case firstPageURL = "first_page_url"
        case fromEntry = "from"
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case source = "path"
        case entriesPerPage = "per_page"
        case prevPageURL = "prev_page_url"
        case toEntry = "to"
        case totalEntries = "total"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currentPage = try container.decode(Int.self, forKey: .currentPage)
        self.source = try container.decode(URL.self, forKey: .source)
        
        self.lastPage = try container.decode(Int.self, forKey: .lastPage)
        self.lastPageURL = try container.decodeIfPresent(URL.self, forKey: .lastPageURL)
        
        self.firstPageURL = try container.decode(URL.self, forKey: .firstPageURL)
        self.prevPageURL = try container.decodeIfPresent(URL.self, forKey: .prevPageURL)
        self.nextPageURL = try container.decodeIfPresent(URL.self, forKey: .nextPageURL)
        
        self.entriesPerPage = try container.decode(Int.self, forKey: .entriesPerPage)
        self.fromEntry = try container.decode(Int.self, forKey: .fromEntry)
        self.toEntry = try container.decode(Int.self, forKey: .toEntry)
        self.totalEntries = try container.decode(Int.self, forKey: .totalEntries)
    }
}

struct IdInfo: Decodable {
    let id: Int
    let name: String
    let code: String?
}
