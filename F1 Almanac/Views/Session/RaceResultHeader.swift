//
//  File.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 17..
//

import Foundation
import SwiftUI

struct RaceResultHeader: View {
    @State var laps: String
    @State var fastestLapDriver: String
    @State var fastestLap: String

    var body: some View {
        HStack(spacing: 8) {
            Text(laps).textStyle(.mediumHeader)
            Spacer()
            Text("Fastest lap -").textStyle(.mediumHeader).foregroundColor(.purple)
            Text(fastestLapDriver).textStyle(.body).foregroundColor(.purple)
            Text(fastestLap).textStyle(.body).foregroundColor(.purple)
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)).background(.tertiary)
    }
}

struct RaceResultHeader_Previews: PreviewProvider {
    static var previews: some View {
        RaceResultHeader(laps: "51 laps", fastestLapDriver: "VER", fastestLap: "1:11.223").previewLayout(PreviewLayout.fixed(width: 375, height: 45))
    }
}
