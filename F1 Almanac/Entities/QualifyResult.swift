//
//  QualifyResult.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

//// MARK: - RaceTable
//struct RaceTable: Codable {
//    let season, round: String
//    let races: [Race]
//
//    enum CodingKeys: String, CodingKey {
//        case season, round
//        case races = "Races"
//    }
//}
//
//// MARK: - Race
//struct Race: Codable {
//    let season, round: String
//    let url: String
//    let raceName: String
//    let circuit: Circuit
//    let date, time: String
//    let qualifyingResults: [QualifyingResult]
//
//    enum CodingKeys: String, CodingKey {
//        case season, round, url, raceName
//        case circuit = "Circuit"
//        case date, time
//        case qualifyingResults = "QualifyingResults"
//    }
//}
//
//// MARK: - Circuit
//struct Circuit: Codable {
//    let circuitID: String
//    let url: String
//    let circuitName: String
//    let location: Location
//
//    enum CodingKeys: String, CodingKey {
//        case circuitID = "circuitId"
//        case url, circuitName
//        case location = "Location"
//    }
//}
//
//// MARK: - Location
//struct Location: Codable {
//    let lat, long, locality, country: String
//}
//
//// MARK: - QualifyingResult
//struct QualifyingResult: Codable {
//    let number, position: String
//    let driver: Driver
//    let constructor: Constructor
//    let q1: String
//    let q2, q3: String?
//
//    enum CodingKeys: String, CodingKey {
//        case number, position
//        case driver = "Driver"
//        case constructor = "Constructor"
//        case q1 = "Q1"
//        case q2 = "Q2"
//        case q3 = "Q3"
//    }
//}
//
//// MARK: - Constructor
//struct Constructor: Codable {
//    let constructorID: String
//    let url: String
//    let name, nationality: String
//
//    enum CodingKeys: String, CodingKey {
//        case constructorID = "constructorId"
//        case url, name, nationality
//    }
//}
//
//// MARK: - Driver
//struct Driver: Codable {
//    let driverID, permanentNumber, code: String
//    let url: String
//    let givenName, familyName, dateOfBirth, nationality: String
//
//    enum CodingKeys: String, CodingKey {
//        case driverID = "driverId"
//        case permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
//    }
//}
