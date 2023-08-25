//
//  RaceStandingViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import SwiftUI
class RaceStandingViewModel: ObservableObject, Injectable {
    var model: RaceStandingModel
    @Published var standings: [DriverStanding] = []

    init(model: RaceStandingModel) {
        self.model = model
    }

    func onAppear() {
        Task {
            let raceStandings = await self.model.getStandings()

            self.standings = driverStandings(from: raceStandings)
        }
    }

    private func driverStandings(from raceStandings: [RaceStanding]) -> [DriverStanding] {
        var driverStandings = raceStandings.first?.laps.first?.timings.map({ DriverStanding(name: $0.driverID , standings: [], color: Color.color(byName: $0.driverID))}) ?? [DriverStanding]()

        raceStandings.forEach { raceStanding in
            raceStanding.laps.forEach { lap in
                for index in 0..<driverStandings.count {
                    if let timing = lap.timings.first(where: { $0.driverID == driverStandings[index].name}) {
                        driverStandings[index].standings.append(Standing(position: Int(timing.position) ?? 0, lap: Int(lap.number) ?? 0))
                    }
                }
            }
        }

        return driverStandings
    }
}

extension Color {
    static func color(byName name: String) -> Color {
        switch name {
        case "perez":
            return Color.blue
        case "max_verstappen":
            return Color.blue
        case "alonso":
            return Color.green
        case "stroll":
            return Color.green
        case "sainz":
            return Color.red
        case "leclerc":
            return Color.red
        case "hamilton":
            return Color.gray
        case "russell":
            return Color.gray
        case "albon":
            return Color.blue
        case "sargeant":
            return Color.blue
        case "de_vries":
            return Color.yellow
        case "tsunoda":
            return Color.yellow
        case "gasly":
            return Color.purple
        case "ocon":
            return Color.purple
        case "norris":
            return Color.orange
        case "piastri":
            return Color.orange
        case "kevin_magnussen":
            return Color.pink
        case "hulkenberg":
            return Color.pink
        case "zhou":
            return Color.brown
        case "bottas":
            return Color.brown
        default:
            return Color.black
        }
    }
}
