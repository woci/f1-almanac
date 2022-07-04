//
//  RaceDetails.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation
import SwiftUI

struct GrandPrixDetailsContainerView: View {
    @StateObject var viewModel: GrandPrixDetailsViewModel
    var body: some View {
        BackgroundViewContainer {
            GrandPrixDetailsView(viewModel: viewModel)
        }
    }
}

struct GrandPrixDetailsView: View {
    @StateObject var viewModel: GrandPrixDetailsViewModel
    var body: some View {
        VStack {
            LazyVStack {
                ForEach(viewModel.rows) { row in
                    if let type = row.type, row.navigationEnabled {
                        NavigationLink(destination: destinationView(by: type, withYear: viewModel.season, withRound: viewModel.round, withSessionName: viewModel.title)) {
                            GrandPrixDetailsRow(title: row.name, formattedDateTime: row.dateTime, chevronIsHidden: false)
                        }.foregroundColor(.primary)
                    } else {
                        GrandPrixDetailsRow(title: row.name, formattedDateTime: row.dateTime, chevronIsHidden: true)
                    }
                }
            }.background(Color.background.opacity(0.7))
                .navigationTitle(viewModel.title)
            Spacer()
        }
    }

    @ViewBuilder func destinationView(by type: Session.SessionType, withYear year: Int, withRound round: Int, withSessionName sessionName: String) -> some View {

        if type == .race {
            let viewModel = RaceResultViewModel(year: year, round: round, title: sessionName)
            RaceResultView(viewModel: viewModel).onAppear {
                viewModel.onAppear()
            }
        } else {
            let viewModel = QualifyingResultViewModel(year: year, round: round, title: sessionName)
            QualifyingResultView(viewModel: viewModel).onAppear {
                viewModel.onAppear()
            }
        }
    }
}



struct RaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GrandPrixDetailsViewModel(title: "Azerbaijan Grand Prix", rows: GrandPrixDetailsRowData.testData, season: 2002, round: 1)
        NavigationView {
            GrandPrixDetailsView(viewModel: viewModel).loadCustomFonts()
        }
    }
}


