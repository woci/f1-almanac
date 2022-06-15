//
//  ScheduleResponse.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation
import SwiftUI

// MARK: - RaceTable
struct Season: Codable {
    let year: Int
    let races: [RaceSchedule]

    enum CodingKeys: String, CodingKey {
        case year = "season"
        case races = "Races"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let year = try container.decode(String.self, forKey: .year)
        if let year = Int(year) {
            self.year = year
        } else {
            let path = [Season.CodingKeys.year] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }

        self.races = try container.decode([RaceSchedule].self, forKey: .races)
    }

    // MARK: - Race
    class RaceSchedule: Race {
        let firstPractice, secondPractice: Session
        let thirdPractice: Session?
        let qualifying: Session
        let sprint: Session?
        private var _sessions: [Session]?

        enum CodingKeys: String, CodingKey {
            case firstPractice = "FirstPractice"
            case secondPractice = "SecondPractice"
            case thirdPractice = "ThirdPractice"
            case qualifying = "Qualifying"
            case sprint = "Sprint"
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.firstPractice = try container.decode(Session.self, forKey: .firstPractice)
            self.secondPractice = try container.decode(Session.self, forKey: .secondPractice)
            self.thirdPractice = try container.decodeIfPresent(Session.self, forKey: .thirdPractice)
            self.qualifying = try container.decode(Session.self, forKey: .qualifying)
            self.sprint = try container.decodeIfPresent(Session.self, forKey: .sprint)

            try super.init(from: decoder)
        }
    }
}

class Race: Codable, Equatable, Identifiable {
    static func == (lhs: Race, rhs: Race) -> Bool {
        lhs.season == rhs.season && lhs.round == rhs.round
    }

    let id: UUID = UUID()
    let season, round: Int
    let url: String
    let raceName: String
    let circuit: Circuit
    let date, time: String

    private enum CodingKeys: String, CodingKey {
        case season, round, url, raceName
        case circuit = "Circuit"
        case date, time
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let season = try container.decode(String.self, forKey: .season)
        if let season = Int(season) {
            self.season = season
        } else {
            let path = [Race.CodingKeys.season] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }

        let round = try container.decode(String.self, forKey: .round)
        if let round = Int(round) {
            self.round = round
        } else {
            let path = [Race.CodingKeys.round] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }
        self.url = try container.decode(String.self, forKey: .url)
        self.raceName = try container.decode(String.self, forKey: .raceName)
        self.circuit = try container.decode(Circuit.self, forKey: .circuit)
        self.date = try container.decode(String.self, forKey: .date)
        self.time = try container.decode(String.self, forKey: .time)
    }
}

extension Season.RaceSchedule {
    var sessions: [Session] {
        if let _sessions = _sessions, !_sessions.isEmpty {
            return _sessions
        }

        var newFP1 = firstPractice
        newFP1.type = .fp1
        var newFP2 = secondPractice
        newFP2.type = .fp2
        var newFP3 = thirdPractice
        newFP3?.type = .fp3

        var newQuali = qualifying
        newQuali.type = .qualify
        var newSprint = sprint
        newSprint?.type = .sprint

        let newRace = Session(type: .race, date: self.date, time: self.time)

        let sessions: [Session?] = [newFP1, newFP2, newFP3, newQuali, newSprint, newRace]

        _sessions = sessions.compactMap{ $0 }.sorted { (lhs: Session, rhs: Session) in
            lhs.dateTime < rhs.dateTime
        }

        return _sessions!
    }
}


// MARK: - Circuit
struct Circuit: Codable {
    let circuitID: String
    let url: String?
    let circuitName: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case circuitID = "circuitId"
        case url, circuitName
        case location = "Location"
    }
}

// MARK: - Location
struct Location: Codable {
    let lat, long, locality, country: String
}

// MARK: - FirstPractice
struct Session: Codable {
    enum SessionType: String, Codable {
        case fp1 = "Free Practice 1"
        case fp2 = "Free Practice 2"
        case fp3 = "Free Practice 3"
        case qualify = "Qualifying"
        case sprint = "Sprint Race"
        case race = "Race"
    }

    var type: SessionType?
    var name: String {
        type?.rawValue ?? "Session"
    }
    let date, time: String
}
