//
//  RaceStandingViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation

class RaceStandingViewModel: ObservableObject, Injectable {
    var model: RaceStandingModel
    var standings: [DriverStanding] = []

    init(model: RaceStandingModel) {
        self.model = model
    }

    func onAppear() {
        Task {
           await self.model.getStandings()
        }
    }
}
