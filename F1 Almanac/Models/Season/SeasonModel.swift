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

    init(year: Int, scheduleService: ScheduleService = RESTSchedulService()) {
        self.year = year
        self.scheduleService = scheduleService
    }

    func loadSeason(ofYear year: Int? = Optional.none) async -> Int {
        if let year = year {
            return year
        }
        
        return self.year
    }
}
