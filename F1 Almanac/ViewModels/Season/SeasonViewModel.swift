//
//  SeasonViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation

@MainActor class SeasonViewModel: ObservableObject {
    var model: SeasonModel
    @Published var showLoader: Bool = false
    @Published var year: String
    @Published var rows: [SeasonRowData] = []

    init(year: Int) {
        self.model = SeasonModel(year: year)
        self.year = "\(year)"
    }
    
    func onAppear() {
        showLoader = true
        Task.init(priority: .userInitiated, operation: {
            guard let season = await model.loadSeason() else {
                showLoader = false
                return
            }

            self.rows.append(contentsOf: season.races.convert())
            self.year = "\(season.year)"

            showLoader = false
        })
    }
}

struct SeasonRowData: Identifiable {
    var id: UUID = UUID()
    var raceName: String
    var formattedDateTime: String
    var sessions: [Session]
    var round: Int
    var season: Int
}

extension Array where Element == Season.RaceSchedule {
    func convert() -> [SeasonRowData] {
        let dateFormatter = CustomDateFormatter()
        return self.map({
            SeasonRowData(raceName: $0.raceName, formattedDateTime: dateFormatter.formattedDate(forDate: $0.date, forTime: $0.time, dateStyle: .medium), sessions: $0.sessions, round: $0.round, season: $0.season)
        })
    }
}


extension SeasonRowData {
    static var testData: [SeasonRowData] {
        [SeasonRowData(raceName: "Monaco Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Hungaroring Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Azerbaijan Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Canada Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),SeasonRowData(raceName: "Monaco Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Hungaroring Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Azerbaijan Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Canada Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),SeasonRowData(raceName: "Monaco Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Hungaroring Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Azerbaijan Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Canada Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),SeasonRowData(raceName: "Monaco Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Hungaroring Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Azerbaijan Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Canada Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),SeasonRowData(raceName: "Monaco Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Hungaroring Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Azerbaijan Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022),
         SeasonRowData(raceName: "Canada Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 1, season: 2022)
        ]
    }
}
