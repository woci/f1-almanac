//
//  DashboardViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation
import UIKit

@MainActor class DashboardViewModel: ObservableObject {
    var model: DashboardModel = DashboardModel()
    @Published var showLoader: Bool = false
    @Published var raceDetailViewModel: GrandPrixDetailsViewModel

    init(raceDetailViewModel: GrandPrixDetailsViewModel) {
        self.raceDetailViewModel = raceDetailViewModel
    }

    private var nextRaceTimer: Timer?

    func onAppear() {
        showLoader = true
        Task.init {
            let nextRace = await model.loadNextRace()

            if let nextRace = nextRace {

                raceDetailViewModel.title = nextRace.raceName
                if let circiutWikiName = nextRace.circuit.circiutWikiName {
                    raceDetailViewModel.nextRaceImage = await model.loadCircuitImage(ofWikiPageName: circiutWikiName, width: UIScreen.main.nativeBounds.width)
                }

                raceDetailViewModel.rows = nextRace.sessions.convert()
                raceDetailViewModel.nextRaceRemainingTime = remainingTime(until: nextRace.dateTime)
                
                nextRaceTimer?.invalidate()
                nextRaceTimer = Optional.none
                nextRaceTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountDown), userInfo: nil, repeats: true)
            } else {
                //TODO
                print("No Next Race")
            }

            showLoader = false
        }
    }

    @objc private func updateCountDown() {
        Task.init {
            let nextRace = await model.loadNextRace()

            if let nextRace = nextRace {
                raceDetailViewModel.nextRaceRemainingTime = remainingTime(until: nextRace.dateTime)
            }
        }
    }

    private func remainingTime(until date: Date) -> String {
        let currentDate = Date()

        let diffDateComponents = Calendar.current.dateComponents([.day,.hour,.minute,.second], from: currentDate, to: date)

        let diffDate = Calendar.current.date(from: diffDateComponents)!

        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let dayFormat = formatter.string(from: diffDate)
        formatter.dateFormat = "HH"
        let hourFormat = formatter.string(from: diffDate)
        formatter.dateFormat = "mm"
        let minuteFormat = formatter.string(from: diffDate)
        formatter.dateFormat = "ss"
        let secondFormat = formatter.string(from: diffDate)

        return "\(dayFormat) \(dayFormat == "1" ? "day" : "days"), \(hourFormat):\(minuteFormat):\(secondFormat)"
    }
}
