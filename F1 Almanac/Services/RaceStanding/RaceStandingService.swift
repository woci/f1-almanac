//
//  RaceStandingService.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation

protocol RaceStandingService: Injectable {
    func standing(forYear year: Int, forRound round: Int, forLap lap: Int) async throws -> RaceWeekend<RaceStanding>
}

struct RESTRaceStandingService: RaceStandingService {
    func standing(forYear year: Int, forRound round: Int, forLap lap: Int) async throws -> RaceWeekend<RaceStanding> {
        let request = RaceStandingRequestBuilder.standing(forYear: year, forRound: round, forLap: lap)

        let result: ResponseResult = await URLSession.shared.send(request: request)
        switch result {
        case .success(let responseData, _):
            return try (JSONDecoder.decode(data: responseData) as Response<RaceWeekend<RaceStanding>>).data.table
        case .error(let error):
            throw error
        }
    }
}
