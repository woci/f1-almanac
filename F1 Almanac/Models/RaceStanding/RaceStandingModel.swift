//
//  RaceStandingModel.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import Swinject

class RaceStandingModel: Injectable {
    var service: RaceStandingService
    var year: Int
    var round: Int
    var laps: Int

    init(service: RaceStandingService, year: Int, round: Int, laps: Int) {
        self.service = service
        self.year = year
        self.round = round
        self.laps = laps
    }

    func getStandings() async -> [RaceStanding] {
        do {
            var unorderedRaceStandings = await withTaskGroup(of: ReorderableRaceStanding?.self) { group in
                for lap in 1...laps {
                    group.addTask { [weak self] in
                        do {
                            let result = try await self?.service.standing(forYear: self?.year ?? 0, forRound: self?.round ?? 0, forLap: lap)
                            guard let raceStanding = result?.table.first else {
                                return Optional.none
                            }
                            return ReorderableRaceStanding(orderElement: lap, raceStanding: raceStanding)
                        } catch {
                            return Optional.none
                        }
                    }
                }

                return await group.reduce(into: [ReorderableRaceStanding](), { partialResult, raceStanding in
                    if let raceStanding = raceStanding {
                        partialResult.append(raceStanding)
                    }
                })
            }

            return unorderedRaceStandings.reorder(by: (1...laps).map({$0})).map({ $0.raceStanding })
        } catch {
            print(error)
        }
    }
}

struct ReorderableRaceStanding: Reorderable {
    typealias OrderElement = Int
    var orderElement: Int
    var raceStanding: RaceStanding

}

protocol Reorderable {
    associatedtype OrderElement: Equatable
    var orderElement: OrderElement { get }
}

extension Array where Element: Reorderable {

    func reorder(by preferredOrder: [Element.OrderElement]) -> [Element] {
        sorted {
            guard let first = preferredOrder.firstIndex(of: $0.orderElement) else {
                return false
            }

            guard let second = preferredOrder.firstIndex(of: $1.orderElement) else {
                return true
            }

            return first < second
        }
    }
}

