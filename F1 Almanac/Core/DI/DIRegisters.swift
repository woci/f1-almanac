//
//  DIRegisters.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 24..
//

import Foundation

extension SwinjectContainer {
    func register() {
        RESTRaceStandingService.register()
        RaceStandingModel.register()
        RaceStandingViewModel.register()
        RaceStandingView.register()
    }
}
