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
        HStack(alignment: .center, spacing: 0) {
            Text("POS").textStyle(.mediumHeader).frame(width: 33, alignment: .bottomLeading).foregroundColor(.primary)
            Text("NAME").textStyle(.mediumHeader).foregroundColor(.primary).padding(.leading, 4)
            Spacer()
            Text("Q1").textStyle(.mediumHeader).frame(width: QualifyingResultView.columnWidth, alignment: .leading).foregroundColor(.primary)
                .padding(.leading, 2)
            Text("Q2").textStyle(.mediumHeader).frame(width: QualifyingResultView.columnWidth, alignment: .leading).foregroundColor(.primary)
                .padding(.leading, 2)
            Text("Q3").textStyle(.mediumHeader).frame(width: QualifyingResultView.columnWidth, alignment: .leading).foregroundColor(.primary)
                .padding(.leading, 2)
            Spacer().frame(width: 5).padding(.trailing, 16)
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0)).background(.tertiary)
    }
}


struct QualifyingResultHeader_Previews: PreviewProvider {
    static var previews: some View {
        QualifyingResultHeader().previewLayout(PreviewLayout.fixed(width: UIScreen.main.bounds.width, height: 31))
    }
}
