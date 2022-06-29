//
//  RaceDetailsRow.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation
import SwiftUI

struct RaceDetailsRow: View {
    @State var title: String
    @State var formattedDateTime: String
    @State var chevronIsHidden: Bool = true
    
    var body: some View {
        VStack{
            Divider().background(Color.separator)
            HStack {
                Text(title).textStyle(.mediumTitle)
                Spacer()
                Text(formattedDateTime)
                    .textStyle(.mediumBody)
                    .frame(minWidth: 50, maxWidth: 150)
                Image(systemName: "chevron.right").isHidden(chevronIsHidden)
            }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
    }
}

struct RaceDetailsRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            RaceDetailsRow(title: "Free Practice 1", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .short, timeStyle: .medium))
            RaceDetailsRow(title: "Free Practice 2", formattedDateTime: CustomDateFormatter().formattedDate(for: Date(), dateStyle: .short, timeStyle: .medium), chevronIsHidden: false)
        }.previewLayout(PreviewLayout.fixed(width: 375, height: 102))
    }
}
