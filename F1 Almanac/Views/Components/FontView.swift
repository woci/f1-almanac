//
//  FontView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 09..
//

import Foundation
import SwiftUI

struct FontView: View {
    var allFonts = TextStyle.allCases

    var body: some View {
        VStack {
            ForEach(0..<allFonts.count) { index in
                Text("\(allFonts[index].name)").textStyle(allFonts[index])
                Spacer().frame(width: .infinity, height: 10, alignment: .center)
            }
        }
    }
}

struct FontView_Previews: PreviewProvider {
    static var previews: some View {
        FontView().loadCustomFonts()
    }
}

private extension TextStyle {
    var name: String {
        switch self {
        case .pageTitle:
            return "Page Title"
        case .largeSubtitle:
            return "Large Subtitle"
        case .title:
            return "Title"
        case .subtitle:
            return "Subtitle"
        case .largeBody:
            return "Large Body"
        case .mediumTitle:
            return "Medium Title"
        case .mediumBody:
            return "Medium Body"
        case .buttonTitle:
            return "Button Title"
        case .mediumHeader:
            return "Medium Header"
        case .body:
            return "Body"
        case .tabBarTitleSelected:
            return "Tabbar Title Selected"
        case .tabBarTitleUnselected:
            return "Tabbar Title Unselected"
        case .smallBody:
            return "Small Body"
        }
    }
}
