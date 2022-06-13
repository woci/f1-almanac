//
//  Races.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation
import SwiftUI

struct SeasonView: View {
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
