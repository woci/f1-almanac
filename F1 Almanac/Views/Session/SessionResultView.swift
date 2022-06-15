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
                    if $viewModel.raceResult.wrappedValue != Optional.none {
                        let results = $viewModel.raceResult.wrappedValue!.table.first!.results
                        LazyVStack {
                            ForEach (results) { result in
                                VStack {
                                    Divider().background(Color.separator)
                                    HStack(alignment: .center, spacing: 8) {
                                        Text("\(result.position).").textStyle(.mediumTitle).padding(.leading, 16).frame(width: 46, alignment: .leading)
                                        Text("#\(result.number)").textStyle(.body).frame(width: 45, alignment: .leading)
                                        Text("+\(result.points)").textStyle(.body).frame(width: 45, alignment: .leading)
                                        Text(NameFormatter().formattedName(forFirstname: result.driver.givenName, forLastName: result.driver.familyName)).textStyle(.body)
                                        Spacer()
                                        Image(systemName: "chevron.right").padding(.trailing, 16)
                                    }.padding(.top, 8).padding(.bottom, 8)
                                }
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
