//
//  SessionResultService.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

protocol SessionResultService {
    func raceResult(forYear year: Int, forRound round: Int) async throws -> RaceWeekend<RaceResult>
    func qualifyResult(forYear year: Int, forRound round: Int) async throws -> RaceWeekend<QualifyResult>
}


struct RESTSessionResultService: SessionResultService {
    func raceResult(forYear year: Int, forRound round: Int) async throws -> RaceWeekend<RaceResult> {
        let request = SessionResultRequestBuilder.raceResult(forYear: year, forRound: round)

        let result = await URLSession.shared.send(request: request)

        switch result {
        case .success(let data, _):
            return try (JSONDecoder.decode(data: data) as Response<RaceWeekend<RaceResult>>).data.table
        case .error(let error):
            throw error
        }
    }

    func qualifyResult(forYear year: Int, forRound round: Int) async throws -> RaceWeekend<QualifyResult> {
        let request = SessionResultRequestBuilder.qualifyResult(forYear: year, forRound: round)

        let result = await URLSession.shared.send(request: request)

        switch result {
        case .success(let data, _):
            return try (JSONDecoder.decode(data: data) as Response<RaceWeekend<QualifyResult>>).data.table
        case .error(let error):
            throw error
        }
    }
}
