//
//  RaceStandingRequestBuilder.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation

struct RaceStandingRequestBuilder {
    enum Endpoint: String {
        case base = "https://ergast.com/api/f1"
    }

    private static func standingURL(forYear year: Int, forRound round: Int, forLap lap: Int) -> URL {
        URL(string: Endpoint.base.rawValue)!
            .appendingPathComponent("\(year)")
            .appendingPathComponent("\(round)")
            .appendingPathComponent("\(lap).json")
    }

    static func standing(forYear year: Int, forRound round: Int, forLap lap: Int) -> URLRequest {
        let url = standingURL(forYear: year, forRound: round, forLap: lap)
        let urlComponents = URLComponents(string: url.absoluteString)!

        return URLRequest(url: urlComponents.url!)
    }
}
