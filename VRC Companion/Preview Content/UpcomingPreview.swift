//
//  UpcomingPreview.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 23/6/2024.
//

import Foundation

extension JSONDecoder {
    static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
}

extension MatchlistModel {
    static var preview: MatchlistModel {
        let url = Bundle.main.url(forResource: "SiegeNationalsMatchlist", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let matchlist = try! JSONDecoder.apiDecoder.decode(MatchlistModel.self, from: data)
        return matchlist
    }
}

extension MatchModel {
    static var preview: MatchModel {
        MatchlistModel.preview.matches[0]
    }
}

extension AllianceModel {
    static var preview: AllianceModel {
        MatchModel.preview.alliances[0]
    }
}

extension TeamModel {
    static var preview: TeamModel {
        AllianceModel.preview.teams[0]
    }
}
