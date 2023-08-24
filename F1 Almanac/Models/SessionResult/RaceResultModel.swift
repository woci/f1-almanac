//
//  SessionResultModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

class RaceResultModel {
    var year: Int
    var round: Int
    var laps: Int
    private var resultService: SessionResultService

    init(year: Int, round: Int, laps: Int, resultService: SessionResultService = RESTSessionResultService()) {
        self.year = year
        self.round = round
        self.laps = laps
        self.resultService = resultService
    }

    func loadQualifyResult() async -> RaceWeekend<QualifyResult>? {
        do {
            return try await resultService.qualifyResult(forYear: year, forRound: round)
        } catch {
            return Optional.none
        }
    }

    func loadRaceResult() async -> RaceWeekend<RaceResult>? {
        do {
            let result = try await resultService.raceResult(forYear: year, forRound: round)
            if let lapsString = result.table.first?.results.first?.laps, let laps = Int(lapsString) {
                self.laps = laps
            }
            return result
        } catch let error {
            print(error)
            return Optional.none
        }
    }
}
