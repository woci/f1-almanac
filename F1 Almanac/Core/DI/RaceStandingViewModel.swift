//
//  RaceStandingViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Swinject

extension RaceStandingViewModel {
    func register() {
        SwinjectContainer.shared.container.register(RaceStandingViewModel.self) { r in
            RaceStandingViewModel(model: r.resolve(RaceStandingModel.self, name: RaceStandingModel.registeredName)!)
        }
    }
}
