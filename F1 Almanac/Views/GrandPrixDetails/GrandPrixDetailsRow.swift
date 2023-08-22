//
//  GrandPrixDetailsRow.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 14..
//

import Foundation
import SwiftUI

struct GrandPrixDetailsRow: View {
    @State var title: String
    @State var formattedDateTime: String
    @State var chevronIsHidden: Bool = true
    
    var body: some View {
        ZStack {
            VStack{
                Divider().background(Color.separator)
                HStack {
                    Text(title).textStyle(.mediumTitle)
                    Spacer()
                    Text(formattedDateTime)
                        .textStyle(.mediumBody)
                        .frame(minWidth: 50, maxWidth: 130, alignment: .leading)
                    Image(systemName: "chevron.right").isHidden(chevronIsHidden)
                }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }
            Rectangle()
                .foregroundColor(.black.opacity(0.2))
                .isHidden(!chevronIsHidden)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: -8, trailing: 0))
        }
    }
}

struct GrandPrixDetailsRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(GrandPrixDetailsRowData.testData) { row in
                GrandPrixDetailsRow(title: row.name, formattedDateTime: row.dateTime).loadCustomFonts()
            }
        }.previewLayout(PreviewLayout.fixed(width: 375, height: 400))
    }
}
