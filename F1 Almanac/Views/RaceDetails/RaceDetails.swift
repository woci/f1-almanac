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
                HStack {
                    Text(session.name ?? "Session").textStyle(.mediumTitle)
                        .padding(.leading, 16)
                        .padding(.top, 8)
                    Spacer()
                    Text("\(session.date) \(session.time)").textStyle(.mediumBody)
                        .padding(.trailing, 16)
                        .padding(.top, 8)
                }
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
