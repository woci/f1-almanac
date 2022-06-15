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
        VStack {
            ForEach(0..<viewModel.race.sessions.count) { index in
                let session = viewModel.race.sessions[index]
                let formattedDateTime = CustomDateFormatter().formattedDate(for: session.dateTime, dateStyle: .medium, timeStyle: .medium )

                let isSessionQualifyOrRace = session.type == .race || session.type == .qualify
                let navigationEnabled = session.dateTime < Date() && isSessionQualifyOrRace

                let viewModel = SessionResultViewModel(year: viewModel.race.season, round: viewModel.race.round, title: session.name)
                NavigationLink(destination: SessionResultView(viewModel: viewModel).onAppear{
                    viewModel.onAppear()
                }) {
                    RaceDetailsRow(title: session.name, formattedDateTime: formattedDateTime, chevronIsHidden: !navigationEnabled)
                }.disabled(!navigationEnabled).foregroundColor(.primary)
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
