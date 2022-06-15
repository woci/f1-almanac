//
//  QualifyResult.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

// MARK: - ResultRace
class QualifyResult: Race {
    let qualifyingResults: [Result]

    enum CodingKeys: String, CodingKey {
        case qualifyingResults = "QualifyingResults"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.qualifyingResults = try container.decode([Result].self, forKey: .qualifyingResults)

        try super.init(from: decoder)
    }

    // MARK: - QualifyingResult
    struct Result: Codable {
        let number, position: String
        let driver: Driver
        let constructor: Constructor
        let q1: String
        let q2, q3: String?

        enum CodingKeys: String, CodingKey {
            case number, position
            case driver = "Driver"
            case constructor = "Constructor"
            case q1 = "Q1"
            case q2 = "Q2"
            case q3 = "Q3"
        }
    }
}

// MARK: - Constructor
struct Constructor: Codable {
    let constructorID: String
    let url: String
    let name, nationality: String

    enum CodingKeys: String, CodingKey {
        case constructorID = "constructorId"
        case url, name, nationality
    }
}

// MARK: - Driver
struct Driver: Codable {
    let driverID, permanentNumber, code: String
    let url: String
    let givenName, familyName, dateOfBirth, nationality: String

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
    }
}
