//
//  ErrorView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 13..
//

import Foundation
import SwiftUI

struct ErrorView: View {
    @State var title: String
    @State var message: String
    @State var buttonTitle: String? = Optional.none
    var buttonAction: (() -> Void)? = Optional.none

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer().padding(.top, 16)
            Text($title.wrappedValue).textStyle(.mediumTitle).padding()
            Text($message.wrappedValue).textStyle(.body).padding() .multilineTextAlignment(.center)
            if let buttonTitle = $buttonTitle.wrappedValue, let buttonAction = buttonAction {
                Button(action: buttonAction) {
                    Text(buttonTitle.uppercased())
                        .textStyle(.buttonTitle).foregroundColor(.primary).padding()
                }.border(.primary)
            }
            Spacer().padding(.bottom, 16)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Error", message: "Something went wront, please try it again later").loadCustomFonts()
    }
}

struct ErrorView_WithButton_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: "Error", message: "Something went wront, please try it again later",buttonTitle: "Try again") {

        }.loadCustomFonts()
    }
}
