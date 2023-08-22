//
//  RaceDetails.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation
import SwiftUI

struct GrandPrixDetailsView: View {
    @StateObject var viewModel: GrandPrixDetailsViewModel
    @EnvironmentObject var seasonViewModel: SeasonViewModel
    var body: some View {
        BackgroundViewContainer {
            ScrollView {
                VStack(spacing: 0) {
                    PlaceholderableAsyncImage(url: $viewModel.nextRaceImage.wrappedValue).frame(width: UIScreen.main.bounds.width).background(Color.background.opacity(0.7))
                    if let remainginTime = $viewModel.nextRaceRemainingTime.wrappedValue {
                        ZStack (alignment: .bottom){
                            Color.primary.opacity(0.6).frame(height: TextStyle.title.lineHeight * 2)
                            Text(remainginTime).textStyle(.title)
                                .foregroundColor(.white)
                                .padding(.bottom, TextStyle.title.lineHeight)
                                .frame(height: TextStyle.title.lineHeight)
                        }.background(Color.background.opacity(0.7))
                    }

                    VStack {
                        LazyVStack {
                            ForEach(viewModel.rows) { row in
                                if let type = row.type, row.navigationEnabled {
                                    NavigationLink(destination: destinationView(by: type, withYear: viewModel.season, withRound: viewModel.round, withSessionName: viewModel.title)) {
                                        GrandPrixDetailsRow(title: row.name, formattedDateTime: row.dateTime, chevronIsHidden: false)
                                    }.foregroundColor(.primary)
                                } else {
                                    GrandPrixDetailsRow(title: row.name, formattedDateTime: row.dateTime, chevronIsHidden: true)
                                }
                            }
                        }.background(Color.background.opacity(0.7))
                            .navigationTitle(viewModel.title)
                        Spacer()
                    }
                }
            }.navigationBarTitle(Text($viewModel.title.wrappedValue), displayMode: .large)
        }
    }

    @ViewBuilder func destinationView(by type: Session.SessionType, withYear year: Int, withRound round: Int, withSessionName sessionName: String) -> some View {

        if type == .race {
            let viewModel = RaceResultViewModel(year: year, round: round, title: sessionName)
            RaceResultView(viewModel: viewModel).onAppear {
                viewModel.onAppear()
            }
        } else {
            let viewModel = QualifyingResultViewModel(year: year, round: round, title: sessionName)
            QualifyingResultView(viewModel: viewModel).onAppear {
                viewModel.onAppear()
            }
        }
    }
}



struct RaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GrandPrixDetailsViewModel(title: "Azerbaijan Grand Prix", rows: GrandPrixDetailsRowData.testData, season: 2002, round: 1, nextRaceRemainingTime: Optional.none, nextRaceImage: Optional.none, model: GrandPrixDetailsModel(race: Season.RaceSchedule(sessions: [Session(type: .fp1, date: "2023.01.01", time: "11:00")], season: 2002, round: 1, url: "", raceName: "Azerbaijan Grand Prix", circuit: Circuit(circuitID: "", url: "", circuitName: "", location: Location(lat: "", long: "", locality: "", country: "")), date: "2023.01.01", time: "11:00")))
        NavigationView {
            GrandPrixDetailsView(viewModel: viewModel).loadCustomFonts()
        }
    }
}


