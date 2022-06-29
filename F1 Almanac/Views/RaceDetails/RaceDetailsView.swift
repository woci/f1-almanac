//
//  RaceDetails.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation
import SwiftUI

struct RaceDetailsView: View {
    @StateObject var viewModel: RaceDetailsViewModel
    var body: some View {
        LazyVStack {
            ForEach(viewModel.rows) { row in
                if let type = row.type, row.navigationEnabled {
                    NavigationLink(destination: destinationView(by: type, withYear: viewModel.season, withRound: viewModel.round, withSessionName: viewModel.title)) {
                        RaceDetailsRow(title: row.name, formattedDateTime: row.dateTime, chevronIsHidden: false)
                    }.foregroundColor(.primary)
                } else {
                    RaceDetailsRow(title: row.name, formattedDateTime: row.dateTime, chevronIsHidden: true)
                }
            }
            Spacer()
        }.navigationTitle(viewModel.title)
        Spacer()
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



//struct RaceDetailsView_Previews: PreviewProvider {
//    static let viewModel = RaceDetailsViewModel(race: <#T##Season.RaceSchedule#>)
//    static var previews: some View {
//        RaceDetailsView(viewModel: viewModel).loadCustomFonts()
//    }
//}


