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
            HStack(alignment: .center, spacing: 0) {
                Text(result.position).textStyle(.mediumHeader).padding(.leading, 16).frame(width: 42, alignment: .bottomLeading).foregroundColor(.primary)
                Text(result.points).textStyle(.tinyBody)
                    .frame(width: 20, alignment: .bottomLeading)
                    .foregroundColor(.secondary)
                    .padding(.leading, 15)
                Text(result.name).textStyle(.mediumBody)
                    .frame(width: 45, alignment: .bottomLeading)
                    .padding(.leading, 23)
                Text(result.number).textStyle(.tinyBody)
                    .frame(width: 25, alignment: .bottomLeading)
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .padding(.leading, 4)
                Spacer()
                Text(result.time).textStyle(.body)
                    .frame(minWidth: 90, alignment: .leading)
                    .padding(.leading, 4)
                Image(systemName: "chevron.right")
                    .padding(.trailing, 16)
            }.padding(.top, 8).padding(.bottom, 8)
        }
    }
}

struct RaceResultRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            ForEach(RaceResultRowData.testData) { row in
                RaceResultRow(result: row)
            }
        }.previewLayout(PreviewLayout.fixed(width: UIScreen.main.bounds.width, height: 200)).loadCustomFonts()
    }
}

extension RaceResultRowData {
    static var testData: [RaceResultRowData] = [
        RaceResultRowData(position: "1.", number: "#44", points: "+25", name: "HAM", time: "1:24:19.293"),
        RaceResultRowData(position: "2.", number: "#1", points: "+18", name: "VER", time: "+ 3.04s"),
        RaceResultRowData(position: "20.", number: "#47", points: "+0", name: "MSC", time: "DNF(Wat)")
    ]
}
