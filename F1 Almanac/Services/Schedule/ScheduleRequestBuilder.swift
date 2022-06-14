//
//  ScheduleRequestBuilder.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

struct ScheduleRequestBuilder {
    enum Endpoint: String {
        case base = "https://ergast.com/api/f1"
        case currentSeason = "current.json"
    }

    static func currentSeasonRequest() -> URLRequest {
        let url = URL(string: Endpoint.base.rawValue)!.appendingPathComponent(Endpoint.currentSeason.rawValue)
        let urlComponents = URLComponents(string: url.absoluteString)!

        return URLRequest(url: urlComponents.url!)
    }

    static func season(ofYear year: Int) -> URLRequest {
        let url = URL(string: Endpoint.base.rawValue)!.appendingPathComponent("\(year).json")
        let urlComponents = URLComponents(string: url.absoluteString)!

        return URLRequest(url: urlComponents.url!)
    }
}
