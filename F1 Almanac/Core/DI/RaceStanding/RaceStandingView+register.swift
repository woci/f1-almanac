//
//  RaceStandingView+register.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 24..
//

import Foundation
import Swinject

extension RaceStandingView {
    static func register() {
        SwinjectContainer.shared.container.register(RaceStandingView.self) { (r: Resolver, year: Int, round: Int, laps: Int) in
            RaceStandingView(viewModel: r.resolve(RaceStandingViewModel.self, name: RaceStandingViewModel.registeredName, arguments: year, round, laps)!)
        }
    }
}
