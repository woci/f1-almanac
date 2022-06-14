//
//  SessionResultService.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

protocol SessionResultService {
    func raceResult(forYear year: Int, forRound round: Int) async throws -> String
    func qualifyResult(forYear year: Int, forRound round: Int) async throws -> String
}


struct RESTSessionResultService: SessionResultService {
    func raceResult(forYear year: Int, forRound round: Int) async throws -> String {
        let request = SessionResultRequestBuilder.raceResult(forYear: year, forRound: round)

        let result = await URLSession.shared.send(request: request)

        switch result {
        case .success(let data, _):
            return String(data: data, encoding: .utf8)!
        case .error(let error):
            throw error
        }
    }

    func qualifyResult(forYear year: Int, forRound round: Int) async throws -> String {
        let request = SessionResultRequestBuilder.qualifyResult(forYear: year, forRound: round)

        let result = await URLSession.shared.send(request: request)

        switch result {
        case .success(let data, _):
            return String(data: data, encoding: .utf8)!
        case .error(let error):
            throw error
        }
    }
}
