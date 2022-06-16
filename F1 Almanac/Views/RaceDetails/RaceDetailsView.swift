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
                let viewModel = SessionResultViewModel(year: viewModel.race.season, round: viewModel.race.round, title: row.name)
                NavigationLink(destination: SessionResultView(viewModel: viewModel).onAppear{
                    viewModel.onAppear()
                }) {
                    RaceDetailsRow(title: row.name, formattedDateTime: row.dateTime, chevronIsHidden: !row.navigationEnabled)
                }.disabled(!row.navigationEnabled).foregroundColor(.primary)
            }
            Spacer()
        }.navigationTitle(viewModel.race.raceName)
    }
}

//struct RaceDetailsView_Previews: PreviewProvider {
//    static let viewModel = RaceDetailsViewModel(race: Race())
//    static var previews: some View {
//        RaceDetailsView(viewModel: viewModel).loadCustomFonts()
//    }
//}
