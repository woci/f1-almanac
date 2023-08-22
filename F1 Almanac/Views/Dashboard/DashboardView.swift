//
//  DashboardView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation
import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel

    var body: some View {
        NavigationView {
            ZStack {
                GrandPrixDetailsView(viewModel: $viewModel.raceDetailViewModel.wrappedValue)
                FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
            }
        }
    }
}

extension Array where Element == Session {
    func convert() -> [GrandPrixDetailsRowData] {
        self.map {
            let isSessionQualifyOrRace = $0.type == .race || $0.type == .qualify
            let navigationEnabled = $0.dateTime < Date() && isSessionQualifyOrRace
            return GrandPrixDetailsRowData(name: $0.name,
                                      dateTime: CustomDateFormatter().formattedDate(for: $0.dateTime,
                                                                                       dateStyle: .medium,
                                                                                       timeStyle: .medium),
                                      navigationEnabled: navigationEnabled,
                                      type: $0.type)
        }
    }
}

struct FullScreenLoader: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        ).background(.white)
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static let viewModel = DashboardViewModel(raceDetailViewModel: GrandPrixDetailsViewModel(title: "Hungaroring Grand Prix", rows: GrandPrixDetailsRowData.testData, season: 2022, round: 11,nextRaceRemainingTime: "4 days, 04:33:57", nextRaceImage: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Silverstone_Circuit_2020.png/1080px-Silverstone_Circuit_2020.png"), model: GrandPrixDetailsModel(race: Season.RaceSchedule(sessions: [Session(type:.fp1, date: "2023.05.26", time: "11:10")], season: 2022, round: 11, url: "", raceName: "Hungaroring Grand Prix", circuit: Circuit(circuitID: "", url: "", circuitName: "", location: Location(lat: "", long: "", locality: "", country: "")), date: "2023.05.26", time: "11:10"))))
    static var previews: some View {
//        viewModel.raceDetailViewModel?.title = "Hungaroring Grand Prix"
//        viewModel.raceDetailViewModel?.nextRaceRemainingTime = "4 days, 04:33:57"
//        viewModel.raceDetailViewModel?.nextRaceImage = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Silverstone_Circuit_2020.png/1080px-Silverstone_Circuit_2020.png")
        return DashboardView(viewModel: viewModel).loadCustomFonts()
    }
}

