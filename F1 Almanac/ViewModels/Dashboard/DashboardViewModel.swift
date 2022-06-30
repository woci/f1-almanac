//
//  DashboardViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

@MainActor class DashboardViewModel: ObservableObject {
    var model: DashboardModel = DashboardModel()
    @Published var showLoader: Bool = false
    @Published var nextRaceName: String = ""
    @Published var nextRaceImage: URL?
    @Published var flagURL: URL = URL(string: "https://google.com")!
    @Published var nextRaceRemainingTime: String = ""

    private var nextRaceTimer: Timer?

    func onAppear() {
        showLoader = true
        Task.init {
            let nextRace = await model.loadNextRace()

            if let nextRace = nextRace {
                nextRaceName = nextRace.raceName
                if let circiutWikiName = nextRace.circuit.circiutWikiName {
                    nextRaceImage = await model.loadCircuitImage(ofWikiPageName: circiutWikiName)
                }

                nextRaceRemainingTime = remainingTime(until: nextRace)

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
                nextRaceRemainingTime = remainingTime(until: nextRace)
            }
        }
    }

    private func remainingTime(until race: Season.RaceSchedule) -> String {
        let currentDate = Date()
        let date = race.dateTime

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
