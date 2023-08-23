//
//  RaceStandingModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Swinject

class RaceStandingModel: Injectable {
    var service: RaceStandingService

    init(service: RaceStandingService) {
        self.service = service
    }
}
