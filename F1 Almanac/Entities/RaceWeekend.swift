//
//  RaceWeekend.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 15..
//

import Foundation

struct RaceWeekend<DataType: Codable>: Codable, Equatable {
    static func == (lhs: RaceWeekend<DataType>, rhs: RaceWeekend<DataType>) -> Bool {
        lhs.year == rhs.year && lhs.round == rhs.round
    }

    let year: Int
    let round: Int
    let table: [DataType]

    enum CodingKeys: String, CodingKey {
        case year = "season"
        case round
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let containerSimple = try decoder.container(keyedBy: CodingKeys.self)
        let containerCustom = try decoder.container(keyedBy: DynamicCodingKeys.self)

        let year = try containerSimple.decode(String.self, forKey: .year)
        if let year = Int(year) {
            self.year = year
        } else {
            let path = [CodingKeys.year] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }

        let round = try containerSimple.decode(String.self, forKey: .round)
        if let round = Int(round) {
            self.round = round
        } else {
            let path = [CodingKeys.round] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode Int but found it failed", underlyingError: nil))
        }

        if let remainingKey = Set(containerCustom.allKeys.map({$0.stringValue})).subtracting(Set(containerSimple.allKeys.map({$0.stringValue}))).first {
            self.table = try containerCustom.decode([DataType].self, forKey: DynamicCodingKeys(stringValue: remainingKey)!)
        } else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Expected to decode \(DataType.self) but key not found for table", underlyingError: nil))
        }
    }
}
