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

extension AllianceTeamModel {
    static var preview: AllianceTeamModel {
        AllianceModel.preview.teams[0]
    }
}

extension RankingsModel {
    static var preview: RankingsModel {
        let url = Bundle.main.url(forResource: "SiegeNationalsRankings", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let rankings = try! JSONDecoder.apiDecoder.decode(APIRankingsModel.self, from: data)
        return rankings.rankings.first!
    }
}

extension EventTeamListModel {
    static var preview: EventTeamListModel {
        let url = Bundle.main.url(forResource: "NationalsTeamList", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let info = try! JSONDecoder.apiDecoder.decode(EventTeamListModel.self, from: data)
        return info
    }
}

extension TeamInfoModel {
    static var preview: TeamInfoModel {
        let url = Bundle.main.url(forResource: "SiegeTeam", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let info = try! JSONDecoder.apiDecoder.decode(TeamInfoModel.self, from: data)
        return info
    }
}

extension EventInfoModel {
    static var preview: EventInfoModel {
        let url = Bundle.main.url(forResource: "NationalsEvent", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let info = try! JSONDecoder.apiDecoder.decode(EventInfoModel.self, from: data)
        return info
    }
}

extension ErrorWrapper {
    static var preview: ErrorWrapper {
        enum SampleError: Error {
            case errorRequired
        }

        return ErrorWrapper(error: SampleError.errorRequired,
                            image: "wifi.exclamationmark", guidance: "API request failed.")
    }
}
