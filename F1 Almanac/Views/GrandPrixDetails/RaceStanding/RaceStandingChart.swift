//
//  RaceStandingView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Charts
import SwiftUI

struct RaceStandingChart: View {
    var standings: [DriverStanding]
    var laps: Int
    var body: some View {
        VStack {
//            Text("Race Standing")
            ScrollView(.horizontal) {
                Chart {
                    ForEach(standings) { driver in
                        ForEach(driver.standings) { standing in
                            LineMark(x: .value("Lap", standing.lap), y: .value("Position", standing.position)).foregroundStyle(by: .value("Name", driver.name))
                                .annotation(position: .overlay,
                                            alignment: .bottom,
                                            spacing: 0) {
                                            Text("\(driver.name)").textStyle(.mediumBody)
                                            }
//                            PointMark(x: .value("Lap", standing.lap), y: .value("Position", standing.position)).foregroundStyle(by: .value("Name", driver.name))
//                                        .opacity(0)
//                                        .annotation(position: .overlay,
//                                                    alignment: .bottom,
//                                                    spacing: 0) {
//                                            Text("\(driver.name)").textStyle(.mediumBody).frame(width: 30)
//                                                    }
                        }
                    }
                }.chartForegroundStyleScale(range: standings.map({$0.color}))
                    .frame(width: 30 * CGFloat(laps))
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: standings.count))
                    }.chartYAxis {
                        AxisMarks(position: .leading, values: .automatic(desiredCount: 20))
                    }.chartXScale(
                        domain: .automatic(includesZero: false, reversed: false)
                    ).chartYScale(
                        domain: .automatic(includesZero: false, reversed: true)
                    )

            }
        }
    }
}

struct DriverStanding: Identifiable {
    var id: UUID = UUID()
    var name: String
    var standings: [Standing]
    var color: Color
}
struct Standing: Identifiable {
    var id: UUID = UUID()
    var position: Int
    var lap: Int
}

struct RaceStandingChart_Previews: PreviewProvider {
    static var previews: some View {
        let standings = (1...20).map { driver in
            DriverStanding(name: String(describing: driver),standings: (1..<70).map { lap in
                Standing(position: (1...20).randomElement()!, lap: lap)
            }, color: Color.random())
        }

        return RaceStandingChart(standings: standings, laps: 70).previewLayout(PreviewLayout.fixed(width: UIScreen.main.bounds.width, height: 400))
    }
}

public extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
