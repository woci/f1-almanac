//
//  Races.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation
import SwiftUI

struct SeasonView: View {
    @StateObject var viewModel: SeasonViewModel

    var body: some View {
        ZStack {
            NavigationView {
                BackgroundViewContainer {
                    ScrollView {
                        if !$viewModel.rows.wrappedValue.isEmpty {
                            LazyVStack {
                                ForEach ($viewModel.rows.wrappedValue) { row in
                                    let race = viewModel.races.first { race in
                                        race.raceName == row.raceName
                                    }
                                    let model = GrandPrixDetailsModel(race: race)
                                    let rowViewModel = GrandPrixDetailsViewModel(title: row.raceName, rows: row.sessions.convert(), season: row.season, round: row.round, model: model)
                                    NavigationLink(destination: GrandPrixDetailsView(viewModel: rowViewModel).onAppear(perform: {
                                        rowViewModel.onAppear()
                                    })) {
                                        SeasonRow(row: row)
                                    }.environmentObject(viewModel)
                                }
                            }
                        } else {
                            ErrorView(title: "Error", message: "Something went wrong please try again later", buttonTitle: "Try Again") {
                                viewModel.onAppear()
                            }.frame(width: UIScreen.main.bounds.width)
                        }
                    }
                    .background(Color.background.opacity(0.7))
                    .navigationBarTitle(Text($viewModel.year.wrappedValue), displayMode: .large)
                }
            }
            FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
        }
    }
}

struct SeasonView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SeasonViewModel(year: 2022)
        viewModel.rows = SeasonRowData.testData
        return SeasonView(viewModel: viewModel).loadCustomFonts()
    }
}

