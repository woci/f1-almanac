//
//  DashboardView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation
import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel

    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    VStack {
                        if let nextRace = viewModel.model.nextRace {
                            NavigationLink(destination:RaceDetailsView(viewModel: RaceDetailsViewModel(race: nextRace))) {
                                PlaceholderableAsyncImage(url: $viewModel.nextRaceImage.wrappedValue)
                                    .background(Color.separator)
                                    .blur(radius: 1.0)
                            }
                        }
                        Text($viewModel.nextRaceRemainingTime.wrappedValue).textStyle(.mediumBody).foregroundColor(.secondary)
                        Spacer()
                    }
                }.background(Color.background).navigationBarTitle(Text($viewModel.nextRaceName.wrappedValue), displayMode: .large)
            }
            FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
        }
    }
}

struct FullScreenLoader: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .scaleEffect(1.5)
            Spacer()
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        ).background(.white)
    }
}

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static let viewModel = DashboardViewModel()
    static var previews: some View {
        DashboardView(viewModel: viewModel).loadCustomFonts()
    }
}
