//
//  RaceStandingModel+register.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Swinject

extension RaceStandingModel {
    static func register() {
        SwinjectContainer.shared.container.register(RaceStandingModel.self, name: RaceStandingModel.registeredName) { r, year, round, laps in
            RaceStandingModel(service: r.resolve(RaceStandingService.self, name: RESTRaceStandingService.registeredName)!, year: year, round: round, laps: laps)
        }
    }
}
