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
