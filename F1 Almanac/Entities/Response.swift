//
//  Response.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

struct Response<DataType: Codable>: Codable {
    let data: ResponseData<DataType>

    enum CodingKeys: String, CodingKey {
        case data = "MRData"
    }
}

// MARK: - MRData
struct ResponseData<DataType: Codable>: Codable {
    let xmlns, series: String
    let url: String
    let limit, offset, total: Int
    let table: DataType

    enum CodingKeys: String, CodingKey {
        case url, limit, offset, total, xmlns, series
    }

    private struct DynamicCodingKeys: CodingKey {
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

        self.xmlns = try containerSimple.decode(String.self, forKey: .xmlns)
        self.series = try containerSimple.decode(String.self, forKey: .series)
        self.url = try containerSimple.decode(String.self, forKey: .url)
        let limit = try containerSimple.decode(String.self, forKey: .limit)
        let offset = try containerSimple.decode(String.self, forKey: .offset)
        let total = try containerSimple.decode(String.self, forKey: .total)
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



        if let remainingKey = Set(containerCustom.allKeys.map({$0.stringValue})).subtracting(Set(containerSimple.allKeys.map({$0.stringValue}))).first {
            self.table = try containerCustom.decode(DataType.self, forKey: DynamicCodingKeys(stringValue: remainingKey)!)
        } else {
            let path = [ScheduleResponse.CodingKeys.data, Schedule.CodingKeys.total] as [CodingKey]
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: path, debugDescription: "Expected to decode \(DataType.self) but key not found re", underlyingError: nil))
        }
    }
}
