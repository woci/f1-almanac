//
//  SessionResultRow.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 16..
//

import Foundation
import SwiftUI


struct SessionResultRow: View {
    @State var result: RaceResultRowData

    var body: some View {
        VStack {
            Divider().background(Color.separator)
            HStack(alignment: .center, spacing: 8) {
                Text(result.position).textStyle(.mediumTitle).padding(.leading, 16).frame(width: 46, alignment: .leading)
                Text(result.number).textStyle(.body).frame(width: 45, alignment: .leading)
                Text(result.points).textStyle(.body).frame(width: 45, alignment: .leading)
                Text(result.name).textStyle(.body)
                Spacer()
                Image(systemName: "chevron.right").padding(.trailing, 16)
            }.padding(.top, 8).padding(.bottom, 8)
        }
    }
}

struct SessionResultRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            SessionResultRow(result: RaceResultRowData(position: "1.", number: "#44", points: "+25", name: "L. Hamilton"))
            SessionResultRow(result: RaceResultRowData(position: "2.", number: "#1", points: "+18", name: "M. Verstappen"))
        }.previewLayout(PreviewLayout.fixed(width: 375, height: 102))
    }
}
