//
//  File.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation

@MainActor class RaceDetailsViewModel: ObservableObject {
    var model: RaceDetailsModel = RaceDetailsModel()
    var race: Schedule.Season.Race

    init(race: Schedule.Season.Race) {
        self.race = race
    }

    func onAppear() {
        if race.dateTime < Date() {
            
        }
    }
}
