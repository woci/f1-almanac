//
//  RaceStanding.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation

// MARK: - Race
class RaceStanding: Race {
    let laps: [Lap]

    enum CodingKeys: String, CodingKey {
        case laps = "Laps"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.laps = try container.decode([Lap].self, forKey: .laps)

        try super.init(from: decoder)
    }
}

struct Lap: Codable {
    let number: String
    let timings: [Timing]

    enum CodingKeys: String, CodingKey {
        case number
        case timings = "Timings"
    }
}

// MARK: - Timing
struct Timing: Codable {
    let driverID, position, time: String

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case position, time
    }
}
