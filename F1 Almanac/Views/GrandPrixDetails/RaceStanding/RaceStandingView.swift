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
        RaceStandingChart(standings: $viewModel.standings.wrappedValue).onAppear(perform: {
            viewModel.onAppear()
        })
    }
}
