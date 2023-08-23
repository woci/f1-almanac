//
//  RaceStandingView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2023. 08. 23..
//

import Foundation
import SwiftUI
import Swinject

struct RaceStandingView: View {
    @ObservedObject var viewModel: RaceStandingViewModel

    init(resolver: Resolver) {
        self.viewModel = resolver.resolve(RaceStandingViewModel.self)!
    }

    var body: some View {
        RaceStandingChart(standings: [])
    }
}
