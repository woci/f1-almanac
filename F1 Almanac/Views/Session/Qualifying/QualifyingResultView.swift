//
//  QualifyingResultView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 21..
//

import Foundation
import SwiftUI

struct QualifyingResultView: View {
    @StateObject var viewModel: QualifyingResultViewModel
    static var columnWidth: CGFloat = 55
    var body: some View {
        ZStack {
            if !$viewModel.rows.wrappedValue.isEmpty {
                VStack(spacing: 0) {
                    QualifyingResultHeader()
                    ScrollView {
                        let results = $viewModel.rows.wrappedValue
                        LazyVStack {
                            ForEach (results) { result in
                                QualifyingResultRow(result: result)
                            }
                        }
                    }.background(Color.background)
                }
            } else {
                ErrorView(title: "Error", message: "Something went wrong please try again later", buttonTitle: "Try Again") {
                    viewModel.onAppear()
                }.frame(width: .infinity)
            }
            FullScreenLoader().isHidden(!$viewModel.showLoader.wrappedValue)
        }.navigationBarTitle(Text(viewModel.title), displayMode: .large)
    }
}

struct QualifyingResultView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = QualifyingResultViewModel(year: 2022, round: 9, title: "Qualifying")
        viewModel.rows = QualifyingResultRowData.testData
        return NavigationView {
            QualifyingResultView(viewModel: viewModel).loadCustomFonts()
        }
    }
}
