//
//  SessionResultViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation

@MainActor class RaceResultViewModel: ObservableObject {
    var model: RaceResultModel

    @Published var showLoader: Bool = false
    @Published var rows: [RaceResultRowData] = []
    @Published var laps: String
    @Published var fastestLap: String
    @Published var fastestLapDriver: String
    var title: String
    
    init(year: Int, round: Int, title: String, laps: String = "", fastestLap: String = "", fastestLapDriver: String = "") {
        self.model = RaceResultModel(year: year, round: round)
        self.title = title
        self.laps = laps
        self.fastestLap = fastestLap
        self.fastestLapDriver = fastestLapDriver
    }

    func onAppear() {
        showLoader = true
        Task.init(priority: .userInitiated, operation: {
            let result = await model.loadRaceResult()
            presentRaceResult(raceResult: result)
        })
    }

    func presentRaceResult(raceResult: RaceWeekend<RaceResult>?) {
        guard let raceResult = raceResult else {
            showLoader = false
            return
        }
        self.rows.removeAll()
        self.rows.append(contentsOf: raceResult.convert())
        if let laps = raceResult.table.first?.results.first?.laps {
            let lap = Int(laps)! > 1 ? "laps" : "lap"
            self.laps = "\(laps) \(lap)"
        }


        if let fastestResult: RaceResult.Result = raceResult.table.first?.results.min(where: { (result: RaceResult.Result) -> TimeInterval in
            guard let time = result.fastestLap?.time.time else {
                return .infinity
            }
            let lapTime = CustomDateFormatter().time(forTime: time)
            print(lapTime)
            return lapTime
        }) {
            self.fastestLap = (fastestResult.fastestLap?.time.time)!
            self.fastestLapDriver = fastestResult.driver.code
        }

        showLoader = false
    }
}

private extension RaceWeekend where DataType == RaceResult {
    func convert() -> [RaceResultRowData] {
        guard let raceresult = table.first else {
            return []
        }

        return raceresult.results.map( {

            RaceResultRowData(position: "\($0.position).",
                              number: "#\($0.number)",
                              points: "+\($0.points)",
                              name: $0.driver.code,
                              time: $0.formattedTime
            )
        })
    }
}

extension Array where Element == RaceResult.Result {
    func min<T: Comparable>(where condition: (RaceResult.Result) -> T) -> RaceResult.Result? {
        var min: T?
        var minResult: RaceResult.Result?
        self.forEach {
            let value = condition($0)
            if let unwrappedMin = min {
                if value < unwrappedMin {
                    min = value
                    minResult = $0
                }
            } else {
                min = value
                minResult = $0
            }
        }

        return minResult
    }
}

private extension RaceResult.Result {
    var formattedTime: String {
        if let time = time?.time {
            return time
        } else if status.contains("Lap") {
            return status
        } else {
            return "DNF(\(String(status.prefix(3))))"
        }
    }
}

struct RaceResultRowData: Identifiable {
    var id: UUID = UUID()
    var position: String
    var number: String
    var points: String
    var name: String
    var time: String
}
