//
//  SessionResult.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation
import SwiftUI

struct SessionResultView: View {
    @StateObject var viewModel: SessionResultViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    if !$viewModel.rows.wrappedValue.isEmpty {
                        let results = $viewModel.rows.wrappedValue
                        LazyVStack {
                            ForEach (results) { result in
                                SessionResultRow(result: result)
                            }
                        }
                    } else {
                        ErrorView(title: "Error", message: "Something went wrong please try again later", buttonTitle: "Try Again") {
                            viewModel.onAppear()
                        }.frame(width: geometry.size.width)
                    }
                }.background(Color.background)
                    .navigationBarTitle(Text(viewModel.title), displayMode: .large)
                FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
            }
        }
    }
}
