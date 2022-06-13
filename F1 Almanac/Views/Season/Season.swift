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
                    VStack {
                        Text($viewModel.year.wrappedValue)
                    }
                }.background(Color.background)
                    .navigationBarTitle(Text($viewModel.year.wrappedValue), displayMode: .large)
            }
            FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
        }
    }
}
