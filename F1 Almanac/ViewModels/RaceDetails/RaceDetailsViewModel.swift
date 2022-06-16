//
//  File.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation

@MainActor class RaceDetailsViewModel: ObservableObject {
    var model: RaceDetailsModel = RaceDetailsModel()
    var race: Season.RaceSchedule
    var rows: [RaceDetailsRowData] = []

    init(race: Season.RaceSchedule) {
        self.race = race
        rows.append(contentsOf: race.sessions.convert())
    }
}

private extension Array where Element == Session {
    func convert() -> [RaceDetailsRowData] {
        self.map {
            let isSessionQualifyOrRace = $0.type == .race || $0.type == .qualify
            let navigationEnabled = $0.dateTime < Date() && isSessionQualifyOrRace
            return RaceDetailsRowData(name: $0.name,
                               dateTime: CustomDateFormatter().formattedDate(for: $0.dateTime,
                                                                                dateStyle: .medium,
                                                                                timeStyle: .medium),
                               navigationEnabled: navigationEnabled)
        }
    }
}

struct RaceDetailsRowData: Identifiable {
    var id: UUID = UUID()
    var name: String
    var dateTime: String
    var navigationEnabled: Bool
}
