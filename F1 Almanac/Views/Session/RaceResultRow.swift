//
//  SessionResultRow.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 16..
//

import Foundation
import SwiftUI

struct RaceResultRow: View {
    @State var result: RaceResultRowData

    var body: some View {
        VStack {
            Divider().background(Color.separator)
            HStack(alignment: .center, spacing: 4) {
                Text(result.position).textStyle(.mediumHeader).padding(.leading, 17).frame(width: 42, alignment: .bottomLeading).foregroundColor(.primary)
                Text(result.points).textStyle(.smallBody).frame(width: 20, alignment: .bottomLeading).foregroundColor(.secondary)
                Text(result.name).textStyle(.body)
                Text(result.number).textStyle(.smallBody).frame(width: 33, alignment: .bottomLeading).foregroundColor(Color(UIColor.tertiaryLabel))
                Spacer()
                Text(result.time).textStyle(.smallBody).frame(width: 75, alignment: .leading)
                Image(systemName: "chevron.right").padding(.trailing, 16)
            }.padding(.top, 8).padding(.bottom, 8)
        }
    }
}

struct SessionResultRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            ForEach(RaceResultRowData.testData) { row in
                RaceResultRow(result: row)
            }
        }.previewLayout(PreviewLayout.fixed(width: 375, height: 124)).loadCustomFonts()
    }
}

extension RaceResultRowData {
    static var testData: [RaceResultRowData] = [
        RaceResultRowData(position: "1.", number: "#44", points: "+25", name: "L. Hamilton", time: "1:24:19.293"),
        RaceResultRowData(position: "2.", number: "#1", points: "+18", name: "M. Verstappen", time: "+ 3.04s"),
        RaceResultRowData(position: "20.", number: "#47", points: "+0", name: "M. Schumacher", time: "DNF(Wit)")
    ]
}
