//
//  QualifyingResultModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 27..
//

import Foundation

class QualifyingResultModel {
    private var year: Int
    private var round: Int
    private var resultService: SessionResultService

    init(year: Int, round: Int, resultService: SessionResultService = RESTSessionResultService()) {
        self.year = year
        self.round = round
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
            return try await resultService.raceResult(forYear: year, forRound: round)
        } catch let error {
            print(error)
            return Optional.none
        }
    }
}
