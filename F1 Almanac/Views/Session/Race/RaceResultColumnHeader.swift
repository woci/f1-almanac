//
//  RaceResultColumnHeader.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 29..
//

import Foundation
import SwiftUI

struct RaceResultColumnHeader: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("POS").textStyle(.mediumHeader).frame(width: 42, alignment: .bottomLeading).foregroundColor(.primary)
            Text("PTS").textStyle(.mediumHeader)
                .frame(width: 31, alignment: .bottomLeading)
                .foregroundColor(.primary)
            Text("NAME").textStyle(.mediumHeader).foregroundColor(.primary)
                .padding(.leading, 10)
            Spacer()
            Text("TIME").textStyle(.mediumHeader).frame(minWidth: 75, maxWidth: 75, alignment: .leading)
//                .padding(.leading, 4)
            Spacer().frame(width: 5).padding(.trailing, 27)
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0)).background(.tertiary)
    }
}

struct RaceResultColumnHeader_Previews: PreviewProvider {
    static var previews: some View {
        RaceResultColumnHeader().previewLayout(PreviewLayout.fixed(width: UIScreen.main.bounds.width, height: 50))
    }
}
