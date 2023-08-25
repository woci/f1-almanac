//
//  RaceStandingView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import SwiftUI
import Swinject

struct RaceStandingView: View, Injectable {
    @ObservedObject var viewModel: RaceStandingViewModel

    var body: some View {
        RaceStandingChart(standings: $viewModel.standings.wrappedValue, laps: $viewModel.model.laps.wrappedValue).onAppear(perform: {
            viewModel.onAppear()
        }).navigationBarTitle(Text("Lap by lap"), displayMode: .large)
    }
}
