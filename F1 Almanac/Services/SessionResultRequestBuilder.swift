//
//  SessionResultRequestBuilder.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

struct SessionResultRequestBuilder {
    enum Endpoint: String {
        case base = "https://ergast.com/api/f1"
        case qualifying = "qualifying.json"
        case race = "results.json"
    }

    private static func sessionURL(forYear year: Int, forRound round: Int, endpoint: Endpoint) -> URL {
        URL(string: Endpoint.base.rawValue)!
            .appendingPathComponent("\(year)")
            .appendingPathComponent("\(round)")
            .appendingPathComponent(endpoint.rawValue)
    }

    static func raceResult(forYear year: Int, forRound round: Int) -> URLRequest {
        let url = sessionURL(forYear: year, forRound: round, endpoint: .race)
        let urlComponents = URLComponents(string: url.absoluteString)!

        return URLRequest(url: urlComponents.url!)
    }

    static func qualifyResult(forYear year: Int, forRound round: Int) -> URLRequest {
        let url = sessionURL(forYear: year, forRound: round, endpoint: .qualifying)
        let urlComponents = URLComponents(string: url.absoluteString)!

        return URLRequest(url: urlComponents.url!)
    }
}
