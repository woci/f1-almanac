//
//  RESTRaceStandingService+register.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 24..
//

import Foundation
import Swinject

extension RESTRaceStandingService {
    static func register() {
        SwinjectContainer.shared.container.register(RaceStandingService.self, name: RESTRaceStandingService.registeredName) { r in
            RESTRaceStandingService()
        }
    }
}
