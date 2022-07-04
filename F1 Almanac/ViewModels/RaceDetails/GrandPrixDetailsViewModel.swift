//
//  File.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation

@MainActor class GrandPrixDetailsViewModel: ObservableObject {
    var model: GrandPrixDetailsModel = GrandPrixDetailsModel()
    var rows: [GrandPrixDetailsRowData] = []
    var title: String
    var season: Int
    var round: Int

    init(title: String, rows: [GrandPrixDetailsRowData], season: Int, round: Int) {
        self.title = title
        self.season = season
        self.round = round
        self.rows.append(contentsOf: rows)
    }
}

struct GrandPrixDetailsRowData: Identifiable {
    var id: UUID = UUID()
    var name: String
    var dateTime: String
    var navigationEnabled: Bool
    var type: Session.SessionType?
}

extension GrandPrixDetailsRowData {
    static var testData: [GrandPrixDetailsRowData] {
        [
        GrandPrixDetailsRowData(name: Session.SessionType.fp1.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.fp1),
        GrandPrixDetailsRowData(name: Session.SessionType.fp2.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.fp2),
        GrandPrixDetailsRowData(name: Session.SessionType.fp3.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.fp3),
        GrandPrixDetailsRowData(name: Session.SessionType.qualify.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.qualify),
        GrandPrixDetailsRowData(name: Session.SessionType.race.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.race)
        ]
    }
}
