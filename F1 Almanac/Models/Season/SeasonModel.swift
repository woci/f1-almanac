//
//  SeasonModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation

class SeasonModel {
    var year: Int
    private var scheduleService: ScheduleService
    private(set) var season: Schedule.Season?

    init(year: Int, scheduleService: ScheduleService = RESTSchedulService()) {
        self.year = year
        self.scheduleService = scheduleService
    }

    func loadSeason(ofYear year: Int? = Optional.none) async -> Schedule.Season? {
        let year = year ?? self.year

        if let season = season, season.year == year {
            return season
        }

        do {
            let schedule = try await self.scheduleService.schedule(ofYear: year)
            self.season = schedule.season
            return self.season
        } catch {
            return Optional.none
        }
    }
}
