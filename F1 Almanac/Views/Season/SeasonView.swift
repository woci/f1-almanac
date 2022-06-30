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
        GeometryReader { geometry in
            ZStack {
                NavigationView {
                    ScrollView {
                        if !$viewModel.rows.wrappedValue.isEmpty {
                            LazyVStack {
                                ForEach ($viewModel.rows.wrappedValue) { row in
                                    NavigationLink(destination: RaceDetailsView(viewModel: RaceDetailsViewModel(title: row.raceName, rows: row.sessions.convert(), season: row.season, round: row.round))) {
                                        SeasonRow(row: row)
                                    }
                                }
                            }
                        } else {
                            ErrorView(title: "Error", message: "Something went wrong please try again later", buttonTitle: "Try Again") {
                                viewModel.onAppear()
                            }.frame(width: geometry.size.width)
                        }
                    }.background(Color.background)
                        .navigationBarTitle(Text($viewModel.year.wrappedValue), displayMode: .large)
                }
                FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
            }
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

