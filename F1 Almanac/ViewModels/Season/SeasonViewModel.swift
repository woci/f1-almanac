//
//  SeasonViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation

@MainActor class SeasonViewModel: ObservableObject {
    var model: SeasonModel

    @Published var showLoader: Bool = false
    @Published var races: [Schedule.Season.Race]?
    @Published var year: String

    init(year: Int) {
        self.model = SeasonModel(year: year)
        self.year = "\(year)"
    }
    
    func onAppear() {
        showLoader = true
        Task.init(priority: .userInitiated, operation: {
            let year = await model.loadSeason()
            self.year = "\(year)"
            showLoader = false
        })
    }
}
