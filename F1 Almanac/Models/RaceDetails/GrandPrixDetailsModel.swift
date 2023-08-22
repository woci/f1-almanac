//
//  RaceDetails.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation

class GrandPrixDetailsModel {
    private var wikiImageService: WikiImageService
    private(set) var race: Season.RaceSchedule?
    private(set) var circuitImage: URL?

    init(wikiImageService: WikiImageService = WikiImageService(), race: Season.RaceSchedule?) {
        self.wikiImageService = wikiImageService
        self.race = race
    }

    func loadResult() {

    }

    func loadCircuitImage(ofWikiPageName pageName: String, width: CGFloat) async -> URL? {
        if let circuitImage = self.circuitImage {
            return circuitImage
        }

        do {
            circuitImage = try await wikiImageService.imageURL(of: pageName, imageSize: width)
            return circuitImage
        } catch {
            print(error)
            return Optional.none
        }
    }
}
