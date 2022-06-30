//
//  DashboardModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation
import UIKit

class DashboardModel {
    private var scheduleService: ScheduleService
    private var countryFlagService: CountryFlagService
    private var wikiImageService: WikiImageService
    private(set) var nextRace: Season.RaceSchedule?
    private(set) var nextRaceCircuitImage: URL?

    init(scheduleService: ScheduleService = RESTSchedulService(), countryFlagService: CountryFlagService = ConcreteCountryFlagService(), wikiImageService: WikiImageService = WikiImageService()) {
        self.scheduleService = scheduleService
        self.countryFlagService = countryFlagService
        self.wikiImageService = wikiImageService
    }

    private func loadCurrentSeasonSchedule() async -> Season? {
        do {
            return try await scheduleService.currentSeasonSchedule()
        } catch {
            return Optional.none
        }
    }

    func loadCircuitImage(ofWikiPageName pageName: String, width: CGFloat) async -> URL? {
        if let nextRaceCircuitImage = self.nextRaceCircuitImage, isActualRaceUpToDate(atDate: Date()) {
            return nextRaceCircuitImage
        }

        do {
            nextRaceCircuitImage = try await wikiImageService.imageURL(of: pageName, imageSize: width)
            return nextRaceCircuitImage
        } catch {
            print(error)
            return Optional.none
        }
    }


    private func isActualRaceUpToDate(atDate currentDate: Date) -> Bool {
        if let nextRace = nextRace, nextRace.dateTime > currentDate {
            return true
        }

        return false
    }

    func loadNextRace() async -> Season.RaceSchedule? {
        let currentDate = Date()

        if isActualRaceUpToDate(atDate: currentDate) {
            return nextRace
        }

        do {
            let currentSeason = try await scheduleService.currentSeasonSchedule()

            let race = currentSeason.nextRace(afterDate: currentDate)

            if let race = race {
                self.nextRace = race
                return race
            } else {
                let components = Calendar.current.dateComponents([.year], from: currentDate)
                if let year = components.year {
                    let nextSeason = try await scheduleService.schedule(ofYear: year)
                    self.nextRace = nextSeason.nextRace(afterDate: currentDate)
                    return self.nextRace
                } else {
                    return Optional.none
                }
            }
        } catch {
            print(error)
            return Optional.none
        }
    }

//    func loadCountryFlag() async throws -> Data {
//
//    }
}

//struct SomeStruct {
//    func doSomething() {
//        InjectedValues[\.scheduleService] = RESTSchedulService()
//    }
//}

extension Season {
    func nextRace(afterDate date: Date) -> Season.RaceSchedule? {
        self.races.first{ $0.dateTime >= date }
    }
}

extension Season.RaceSchedule {
    var raceWikiName: String? {
        self.url.components(separatedBy: "wiki/").last
    }
}

extension Circuit {
    var circiutWikiName: String? {
        self.url?.components(separatedBy: "wiki/").last
    }
}
