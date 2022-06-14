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
                        if $viewModel.races.wrappedValue != Optional.none {
                            LazyVStack {
                                ForEach ($viewModel.races.wrappedValue!) { race in
                                    NavigationLink(destination: RaceDetailsView(viewModel: RaceDetailsViewModel(race: race))) {
                                        HStack {
                                            Text(race.raceName)
                                            Spacer()
                                            Text(CustomDateFormatter().formattedDate(forDate: race.date, forTime: race.time, dateStyle: .medium))
                                            Image(systemName: "chevron.right")
                                        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                            .foregroundColor(.primary)
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
