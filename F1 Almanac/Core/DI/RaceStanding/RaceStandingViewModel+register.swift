//
//  RaceStandingViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Swinject

extension RaceStandingViewModel {
    static func register() {
        SwinjectContainer.shared.container.register(RaceStandingViewModel.self, name: RaceStandingViewModel.registeredName) { (r: Resolver, year: Int, round: Int, laps: Int) in
            RaceStandingViewModel(model: r.resolve(RaceStandingModel.self, name: RaceStandingModel.registeredName, arguments: year, round, laps)!)
        }
    }
}
