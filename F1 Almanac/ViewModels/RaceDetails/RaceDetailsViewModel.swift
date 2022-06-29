//
//  File.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation

@MainActor class RaceDetailsViewModel: ObservableObject {
    var model: RaceDetailsModel = RaceDetailsModel()
    var rows: [RaceDetailsRowData] = []
    var title: String
    var season: Int
    var round: Int

    init(title: String, rows: [RaceDetailsRowData], season: Int, round: Int) {
        self.title = title
        self.season = season
        self.round = round
        self.rows.append(contentsOf: rows)
    }
}

struct RaceDetailsRowData: Identifiable {
    var id: UUID = UUID()
    var name: String
    var dateTime: String
    var navigationEnabled: Bool
    var type: Session.SessionType?
}
