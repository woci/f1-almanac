//
//  SessionResult.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation
import SwiftUI

struct RaceResultView: View {
    @StateObject var viewModel: RaceResultViewModel

    var body: some View {
        ZStack {
            ScrollView {
                if !$viewModel.rows.wrappedValue.isEmpty {
                    let results = $viewModel.rows.wrappedValue
                    VStack(alignment: .leading, spacing: 0) {
                        RaceResultHeader(laps: $viewModel.laps.wrappedValue, fastestLapDriver: $viewModel.fastestLapDriver.wrappedValue, fastestLap: $viewModel.fastestLap.wrappedValue)
                        LazyVStack {
                            ForEach (results) { result in
                                RaceResultRow(result: result)
                            }
                        }
                    }
                } else {
                    ErrorView(title: "Error", message: "Something went wrong please try again later", buttonTitle: "Try Again") {
                        viewModel.onAppear()
                    }.frame(width: .infinity)
                }
            }.background(Color.background)
                .navigationBarTitle(Text(viewModel.title), displayMode: .large)
            FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
        }
    }
}

struct SessionResultView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RaceResultViewModel(year: 2022, round: 8, title: "Race", laps: "51 laps", fastestLap: "1:24.111", fastestLapDriver: "HAM")
        viewModel.rows = RaceResultRowData.testData
        return NavigationView {
            RaceResultView(viewModel: viewModel)
        }.loadCustomFonts()
            .previewDevice("iPhone SE (2nd generation)")
    }
}
