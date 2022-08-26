//
//  QualifyingResultRow.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 29..
//

import Foundation
import SwiftUI

struct QualifyingResultRow: View {
    @State var result: QualifyingResultRowData
    
    var body: some View {
        VStack {
            Divider().background(Color.separator)
            HStack(alignment: .center, spacing: 0) {
                Text(result.position).textStyle(.mediumHeader)
                    .padding(.leading, 16).frame(width: 42, alignment: .bottomLeading).foregroundColor(.primary)
                Text(result.name).textStyle(.mediumBody)
                    .frame(width: 45, alignment: .bottomLeading)
                    .padding(.leading, 11)
                Text(result.number).textStyle(.tinyBody)
                    .frame(width: 25, alignment: .bottomLeading)
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                Spacer()
                Text(result.q1).textStyle(.body)
                    .frame(width: QualifyingResultView.columnWidth, alignment: .leading)
                if let q2 = result.q2 {
                    Text(q2).textStyle(.body)
                        .frame(width: QualifyingResultView.columnWidth, alignment: .leading)
                        .padding(.leading, 2)
                } else {
                    ColumnSpacer()
                }

                if let q3 = result.q3 {
                    Text(q3).textStyle(.body)
                        .frame(width: QualifyingResultView.columnWidth, alignment: .leading)
                        .padding(.leading, 2)
                } else {
                    ColumnSpacer()
                }
                Image(systemName: "chevron.right")
                    .frame(width: 5)
                    .padding(.trailing, 16)
            }.padding(.top, 8)
                .padding(.bottom, 8)
        }
    }
}

struct ColumnSpacer: View {
    var body: some View {
        Spacer().frame(width: QualifyingResultView.columnWidth, alignment: .leading).padding(.leading, 2)
    }
}

struct QualifyingResultRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            ForEach(QualifyingResultRowData.testData) { row in
                QualifyingResultRow(result: row)
            }
        }.previewDevice("iPhone 13 mini").previewLayout(PreviewLayout.fixed(width: UIScreen.main.bounds.width, height: 300)).loadCustomFonts()
    }
}

