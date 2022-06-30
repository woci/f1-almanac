//
//  SeasonRow.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 30..
//

import Foundation
import SwiftUI

struct SeasonRow: View {
    @State var row: SeasonRowData

    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(row.raceName).textStyle(.body)
                    .foregroundColor(.primary)
                Spacer()
                Text(row.formattedDateTime).textStyle(.mediumHeader)
                Image(systemName: "chevron.right")
            }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                .foregroundColor(.primary)
        }
    }
}

struct SeasonRow_Previews: PreviewProvider {
    static var previews: some View {
        SeasonRow(row: SeasonRowData(raceName: "Monaco Grand Prix", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .medium), sessions: [], round: 6, season: 2022)).previewLayout(PreviewLayout.fixed(width: UIScreen.main.bounds.width, height: 42))
    }
}
