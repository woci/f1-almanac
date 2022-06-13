//
//  ScheduleResponse.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

import Foundation

// MARK: - ScheduleResponse
struct ScheduleResponse: Codable {
    let data: Schedule

    enum CodingKeys: String, CodingKey {
        case data = "MRData"
    }

}

// MARK: - MRData
struct Schedule: Codable {
    let url: String
    let limit, offset, total: Int
    let season: Season

    enum CodingKeys: String, CodingKey {
        case url, limit, offset, total
        case season = "RaceTable"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        let limit = try container.decode(String.self, forKey: .limit)
        let offset = try container.decode(String.self, forKey: .offset)
        let total = try container.decode(String.self, forKey: .total)
        if let limit = Int(limit) {
            self.limit = limit
        } else {
            let path = [ScheduleResponse.CodingKeys.data, Schedule.CodingKeys.limit] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }

        if let offset = Int(offset) {
            self.offset = Int(offset)
        } else {
            let path = [ScheduleResponse.CodingKeys.data, Schedule.CodingKeys.offset] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }

        if let total = Int(total) {
            self.total = Int(total)
        } else {
            let path = [ScheduleResponse.CodingKeys.data, Schedule.CodingKeys.total] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }

        self.season = try container.decode(Season.self, forKey: .season)
    }

    // MARK: - RaceTable
    struct Season: Codable {
        let year: Int
        let races: [Race]

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
                let path = [ScheduleResponse.CodingKeys.data, Schedule.CodingKeys.season, Season.CodingKeys.year] as [CodingKey]
                throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
            }

            self.races = try container.decode([Race].self, forKey: .races)
        }

        // MARK: - Race
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
            let firstPractice, secondPractice: Session
            let thirdPractice: Session?
            let qualifying: Session
            let sprint: Session?
            private var _sessions: [Session]?
            var sessions: [Session] {
                if let _sessions = _sessions, !_sessions.isEmpty {
                    return _sessions
                }

                var newFP1 = firstPractice
                newFP1.name = "Free Practice 1"
                var newFP2 = secondPractice
                newFP2.name = "Free Practice 2"
                var newFP3 = thirdPractice
                newFP3?.name = "Free Practice 3"

                var newQuali = qualifying
                newQuali.name = "Qualifying"
                var newSprint = sprint
                newSprint?.name = "Sprint Race"

                let newRace = Session(name: "Race", date: self.date, time: self.time)

                let sessions: [Session?] = [newFP1, newFP2, newFP3, newQuali, newSprint, newRace]

                _sessions = sessions.compactMap{ $0 }.sorted { (lhs: Session, rhs: Session) in
                    lhs.dateTime < rhs.dateTime
                }

                return _sessions!
            }

            enum CodingKeys: String, CodingKey {
                case season, round, url, raceName
                case circuit = "Circuit"
                case date, time
                case firstPractice = "FirstPractice"
                case secondPractice = "SecondPractice"
                case thirdPractice = "ThirdPractice"
                case qualifying = "Qualifying"
                case sprint = "Sprint"
            }

            required init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let season = try container.decode(String.self, forKey: .season)
                if let season = Int(season) {
                    self.season = season
                } else {
                    let path = [ScheduleResponse.CodingKeys.data, Schedule.CodingKeys.season, Race.CodingKeys.season] as [CodingKey]
                    throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
                }

                let round = try container.decode(String.self, forKey: .round)
                if let round = Int(round) {
                    self.round = round
                } else {
                    let path = [ScheduleResponse.CodingKeys.data, Schedule.CodingKeys.season, Race.CodingKeys.round] as [CodingKey]
                    throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
                }
                self.url = try container.decode(String.self, forKey: .url)
                self.raceName = try container.decode(String.self, forKey: .raceName)
                self.circuit = try container.decode(Circuit.self, forKey: .circuit)
                self.date = try container.decode(String.self, forKey: .date)
                self.time = try container.decode(String.self, forKey: .time)
                self.firstPractice = try container.decode(Session.self, forKey: .firstPractice)
                self.secondPractice = try container.decode(Session.self, forKey: .secondPractice)
                self.thirdPractice = try container.decodeIfPresent(Session.self, forKey: .thirdPractice)
                self.qualifying = try container.decode(Session.self, forKey: .qualifying)
                self.sprint = try container.decodeIfPresent(Session.self, forKey: .sprint)
            }
        }

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
    var name: String?
    let date, time: String
}
