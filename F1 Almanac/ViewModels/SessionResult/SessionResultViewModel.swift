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
    @Published var rows: [RaceResultRowData] = []
    var title: String
    
    init(year: Int, round: Int, title: String) {
        self.model = SessionResultModel(year: year, round: round)
        self.title = title
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
                              name: NameFormatter().formattedName(forFirstname: $0.driver.givenName,
                                                                  forLastName: $0.driver.familyName,
                                                                  style: .firstWordAbbreviated)
            )
        })
    }
}

struct RaceResultRowData: Identifiable {
    var id: UUID = UUID()
    var position: String
    var number: String
    var points: String
    var name: String
}
