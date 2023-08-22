//
//  QualifyingResultViewModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 21..
//

import Foundation

@MainActor class QualifyingResultViewModel: ObservableObject {
    var model: QualifyingResultModel
    @Published var showLoader: Bool = false
    @Published var rows: [QualifyingResultRowData] = []
    var title: String


    init(year: Int, round: Int, title: String) {
        self.model = QualifyingResultModel(year: year, round: round)
        self.title = title
    }

    func onAppear() {
        showLoader = true
        Task.init(priority: .userInitiated, operation: {
            let result = await model.loadQualifyResult()
            presentQualifyingResult(qualifyingResult: result)
        })
    }

    func presentQualifyingResult(qualifyingResult: RaceWeekend<QualifyResult>?) {
        guard let qualifyingResult = qualifyingResult else {
            showLoader = false
            return
        }
        self.rows.removeAll()
        self.rows.append(contentsOf: qualifyingResult.convert())

        showLoader = false
    }
}


private extension RaceWeekend where DataType == QualifyResult {
    func convert() -> [QualifyingResultRowData] {
        guard let qualifyingResult = table.first else {
            return []
        }


        return qualifyingResult.qualifyingResults.map( {
            QualifyingResultRowData(position: "\($0.position).",
                                    number: "#\($0.number)",
                                    name: $0.driver.code,
                                    q1: $0.q1,
                                    q2: $0.q2,
                                    q3: $0.q3)
        })
    }
}

struct QualifyingResultRowData: Identifiable {
    var id: UUID = UUID()
    var position: String
    var number: String
    var name: String
    var q1: String
    var q2: String?
    var q3: String?
}

extension QualifyingResultRowData {
    static var testData: [QualifyingResultRowData] = [
        QualifyingResultRowData(position: "3.", number: "#1", name: "VER", q1: "1:42.722", q2: "1:42.227", q3: "1:41.706"),
        QualifyingResultRowData(position: "2.", number: "#14", name: "ALO", q1: "1:32.277", q2: "1:24.848", q3: "1:21.944"),
        QualifyingResultRowData(position: "11.", number: "#77", name: "BOT", q1: "1:33.689", q2: "1:26.788", q3: Optional.none),
        QualifyingResultRowData(position: "18.", number: "#47", name: "MSC", q1: "1:35.650", q2: Optional.none, q3: Optional.none),
        QualifyingResultRowData(position: "20.", number: "#6", name: "LAT", q1: "1:35.660", q2: Optional.none, q3: Optional.none)
    ]
}
