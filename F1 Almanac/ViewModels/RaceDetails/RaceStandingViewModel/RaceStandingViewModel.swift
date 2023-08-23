//
//  RaceStandingViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation

class RaceStandingViewModel: ObservableObject {
    var model: RaceStandingModel

    init(model: RaceStandingModel) {
        self.model = model
    }
}
