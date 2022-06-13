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
                ScrollView {
                    if let races = $viewModel.races.wrappedValue {
                        LazyVStack {
                            ForEach ($viewModel.races.wrappedValue!) { race in
                                NavigationLink(destination: RaceDetailsView(viewModel: RaceDetailsViewModel(race: race))) {
                                    HStack {
                                        Text(race.raceName)
                                        Spacer()
                                        Text(race.date + race.time)
                                    }.padding(.leading, 16)
                                        .padding(.top, 8)
                                        .padding(.bottom, 8)
                                        .padding(.trailing, 16)
                                }
                            }
                        }
                    }
                }.background(Color.background)
                    .navigationBarTitle(Text($viewModel.year.wrappedValue), displayMode: .large)
            }
            FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
        }
    }
}
