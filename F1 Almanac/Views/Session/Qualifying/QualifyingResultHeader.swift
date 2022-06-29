//
//  QualifyingResultHeader.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 29..
//

import Foundation
import SwiftUI

struct QualifyingResultHeader: View {
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text("POS").textStyle(.mediumHeader).frame(width: 33, alignment: .bottomLeading).foregroundColor(.primary)
            Text("Name").textStyle(.mediumHeader).foregroundColor(.primary)
            Spacer().frame(width:14)
            Spacer()
            Text("Q1").textStyle(.mediumHeader).frame(width: QualifyingResultView.columnWidth, alignment: .leading).foregroundColor(.primary)
            Text("Q2").textStyle(.mediumHeader).frame(width: QualifyingResultView.columnWidth, alignment: .leading).foregroundColor(.primary)
            Text("Q3").textStyle(.mediumHeader).frame(width: QualifyingResultView.columnWidth, alignment: .leading).foregroundColor(.primary)
            Spacer().frame(width: 5).padding(.trailing, 16)
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0)).background(.tertiary)
    }
}
