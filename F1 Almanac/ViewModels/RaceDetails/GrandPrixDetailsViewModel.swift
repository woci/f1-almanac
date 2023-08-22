//
//  File.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation
import UIKit

@MainActor protocol GrandPrixDetailsViewModelProtocol: ObservableObject {
    var model: GrandPrixDetailsModel { get set }
    var rows: [GrandPrixDetailsRowData] { get set }
    var nextRaceImage: URL? { get set }
    var title: String { get set }
    var season: Int { get set }
    var round: Int { get set }
}

class GrandPrixDetailsViewModel: GrandPrixDetailsViewModelProtocol {
    var model: GrandPrixDetailsModel
    @Published var rows: [GrandPrixDetailsRowData] = []
    @Published var nextRaceRemainingTime: String?
    @Published var nextRaceImage: URL?
    @Published var title: String
    var season: Int
    var round: Int

    init(title: String, rows: [GrandPrixDetailsRowData], season: Int, round: Int, nextRaceRemainingTime: String? = Optional.none, nextRaceImage: URL? = Optional.none, model: GrandPrixDetailsModel) {
        self.model = model
        self.title = title
        self.season = season
        self.round = round
        self.rows.append(contentsOf: rows)
        self.nextRaceRemainingTime = nextRaceRemainingTime
        self.nextRaceImage = nextRaceImage
    }

    func onAppear() {
        if let circiutWikiName = model.race?.circuit.circiutWikiName {
            Task.init(priority: .userInitiated, operation: {
                nextRaceImage = await model.loadCircuitImage(ofWikiPageName: circiutWikiName, width: UIScreen.main.nativeBounds.width)
            })
        }
    }
}

struct GrandPrixDetailsRowData: Identifiable {
    var id: UUID = UUID()
    var name: String
    var dateTime: String
    var navigationEnabled: Bool
    var type: Session.SessionType?
}

extension GrandPrixDetailsRowData {
    static var testData: [GrandPrixDetailsRowData] {
        [
        GrandPrixDetailsRowData(name: Session.SessionType.fp1.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.fp1),
        GrandPrixDetailsRowData(name: Session.SessionType.fp2.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.fp2),
        GrandPrixDetailsRowData(name: Session.SessionType.fp3.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.fp3),
        GrandPrixDetailsRowData(name: Session.SessionType.qualify.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.qualify),
        GrandPrixDetailsRowData(name: Session.SessionType.race.rawValue, dateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium, timeStyle: .medium), navigationEnabled: false, type: Session.SessionType.race)
        ]
    }
}
