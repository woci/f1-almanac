//
//  ContentView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            let dashboardViewModel = DashboardViewModel(raceDetailViewModel: GrandPrixDetailsViewModel(title: "", rows: [], season: 0, round: 0, nextRaceRemainingTime: Optional.none, nextRaceImage: Optional.none, model: GrandPrixDetailsModel(race: Season.RaceSchedule(sessions: [], season: 0, round: 0, url:"", raceName: "",circuit: Circuit(circuitID: "", url: Optional.none, circuitName: "", location: Location.init(lat: "", long: "", locality: "", country: "")), date: "", time: ""))))
            DashboardView(viewModel: dashboardViewModel).tabItem { TabViewItem(type: .currentGP) }.onAppear {
                dashboardViewModel.onAppear()
            }
            let seasonViewModel = SeasonViewModel(year: Calendar.current.dateComponents([.year], from: Date()).year!)
            SeasonView(viewModel: seasonViewModel).tabItem {
                TabViewItem(type: .season) }.onAppear {
                    seasonViewModel.onAppear()
                }
        }
    }
}

struct TabViewItem: View {

    var type: TabViewItemType

    var body: some View {
        VStack {
            type.image
            type.text
        }
    }
}

enum TabViewItemType: String {
    case currentGP  = "Current Grand Prix"
    case season  = "Season"

    var image: Image {
        switch self {
        case .currentGP:  return Image(systemName: "macwindow")
        case .season:  return Image(systemName: "list.dash")
        }
    }

    var text: Text {
        Text(self.rawValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
