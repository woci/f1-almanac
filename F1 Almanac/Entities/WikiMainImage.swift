//
//  WikiMainImage.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 03..
//

import Foundation

// MARK: - WikiMainImage
struct WikiMainImageResponse: Codable {
    let batchcomplete: String
    let query: Query
}

// MARK: - Query
struct Query: Codable {
    let normalized: [Normalized]
    let pages: Pages
}

// MARK: - Normalized
struct Normalized: Codable {
    let from, to: String
}

// MARK: - Pages
struct Pages: Codable {
    let page: Page

    private struct DynamicCodingKeys: CodingKey {

            // Use for string-keyed dictionary
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }

            // Use for integer-keyed dictionary
            var intValue: Int?
            init?(intValue: Int) {
                // We are not using this, thus just return nil
                return nil
            }
        }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        if let key = container.allKeys.first {
            self.page = try container.decode(Page.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
        } else {
            throw DecodingError.valueNotFound(Int.self, DecodingError.Context(codingPath: [], debugDescription: "Expected to decode pageID but found nil, at path: WikiMainImageResponse.Query.Pages.Page", underlyingError: nil))
        }
    }
}

struct Page: Codable {
    let pageid, ns: Int
    let title: String
    let thumbnail: Thumbnail
    let pageimage: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let source: String
    let width, height: Int
}
