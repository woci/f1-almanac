//
//  SessionResultViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

@MainActor class SessionResultViewModel: ObservableObject {
    var model: SessionResultModel

    @Published var showLoader: Bool = false
    var title: String
    
    init(year: Int, round: Int, title: String) {
        self.model = SessionResultModel(year: year, round: round)
        self.title = title
    }

    func onAppear() {
        showLoader = true
        Task.init(priority: .userInitiated, operation: {
//            guard let season = await model.loadSeason() else {
//                races = Optional.none
//                showLoader = false
//                return
//            }
//
//            self.races = season.races
//            self.year = "\(season.year)"

            showLoader = false
        })
    }
}
