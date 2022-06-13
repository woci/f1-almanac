//
//  File.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation

@MainActor class RaceDetailsViewModel: ObservableObject {
    var race: Race

    init(race: Race) {
        self.race = race
    }

    func onAppear() {
        
    }
}
