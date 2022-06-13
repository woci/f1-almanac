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
            let dashboardViewModel = DashboardViewModel()
            DashboardView(viewModel: dashboardViewModel).tabItem { TabViewItem(type: .dashboard) }.onAppear {
                dashboardViewModel.onAppear()
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
    case dashboard  = "Dashboard"

    var image: Image {
        switch self {
        case .dashboard:  return Image(systemName: "macwindow")
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
