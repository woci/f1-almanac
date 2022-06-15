//
//  RaceResult.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 15..
//

import Foundation

// MARK: - Race
class RaceResult: Race {
    let results: [Result]

    private enum CodingKeys: String, CodingKey {
        case results = "Results"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Result].self, forKey: .results)

        try super.init(from: decoder)
    }

    // MARK: - Result
    struct Result: Codable, Identifiable {
        let id: UUID = UUID()
        let number, position, positionText, points: String
        let driver: Driver
        let constructor: Constructor
        let grid, laps: String
        let status: String
        let time: ResultTime?
        let fastestLap: FastestLap?

        enum CodingKeys: String, CodingKey {
            case number, position, positionText, points
            case driver = "Driver"
            case constructor = "Constructor"
            case grid, laps, status
            case time = "Time"
            case fastestLap = "FastestLap"
        }
    }
}

// MARK: - FastestLap
struct FastestLap: Codable {
    let rank, lap: String
    let time: FastestLapTime
    let averageSpeed: AverageSpeed

    enum CodingKeys: String, CodingKey {
        case rank, lap
        case time = "Time"
        case averageSpeed = "AverageSpeed"
    }
}

// MARK: - AverageSpeed
struct AverageSpeed: Codable {
    let units: Units
    let speed: String
}

enum Units: String, Codable {
    case kph = "kph"
}

// MARK: - FastestLapTime
struct FastestLapTime: Codable {
    let time: String
}

// MARK: - ResultTime
struct ResultTime: Codable {
    let millis, time: String
}
