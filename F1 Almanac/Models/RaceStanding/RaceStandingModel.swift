//
//  RaceStandingModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Swinject

class RaceStandingModel: Injectable {
    var service: RaceStandingService
    var year: Int
    var round: Int
    var laps: Int

    init(service: RaceStandingService, year: Int, round: Int, laps: Int) {
        self.service = service
        self.year = year
        self.round = round
        self.laps = laps
    }

    func getStandings() async {
        do {
            let result = try await service.standing(forYear: year, forRound: round, forLap: laps)
        } catch {
            print(error)
        }
    }
}
