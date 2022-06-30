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
        ZStack {
            NavigationView {
                ScrollView {
                    ZStack {
                        VStack(spacing: 0) {
                            ZStack (alignment: .bottom){
                                if let nextRace = viewModel.model.nextRace {
                                    NavigationLink(destination:RaceDetailsView(viewModel: RaceDetailsViewModel(title: nextRace.raceName, rows: nextRace.sessions.convert(), season: nextRace.season, round: nextRace.round))) {
                                        PlaceholderableAsyncImage(url: $viewModel.nextRaceImage.wrappedValue)
                                    }
                                }
                                Color.black.opacity(0.7).frame(height: TextStyle.title.lineHeight * 2)
                                Text($viewModel.nextRaceRemainingTime.wrappedValue).textStyle(.title).foregroundColor(.white).shadow(radius: 10)
                                    .padding(.bottom, TextStyle.title.lineHeight)
                                    .frame(height: TextStyle.title.lineHeight)
                            }
                            if $viewModel.raceDetailViewModel.wrappedValue != nil {
                                RaceDetailsView(viewModel: $viewModel.raceDetailViewModel.wrappedValue!)
                            } else {
                                Spacer()
                            }
                        }
                    }
                }.background(Color.background).navigationBarTitle(Text($viewModel.nextRaceName.wrappedValue), displayMode: .large)
            }
            FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
        }
    }
}

extension Array where Element == Session {
    func convert() -> [RaceDetailsRowData] {
        self.map {
            let isSessionQualifyOrRace = $0.type == .race || $0.type == .qualify
            let navigationEnabled = $0.dateTime < Date() && isSessionQualifyOrRace
            return RaceDetailsRowData(name: $0.name,
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
    static let viewModel = DashboardViewModel()
    static var previews: some View {
        viewModel.nextRaceName = "Hungaroring Grand Prix"
        viewModel.nextRaceRemainingTime = "4 days, 04:33:57"
        viewModel.nextRaceImage = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Silverstone_Circuit_2020.png/1080px-Silverstone_Circuit_2020.png")
        return DashboardView(viewModel: viewModel).loadCustomFonts()
    }
}

