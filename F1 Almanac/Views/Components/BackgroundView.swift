//
//  BackgroundView.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 30..
//

import Foundation
import SwiftUI

struct BackgroundView: View {
    var blurRadius: CGFloat

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("f1_logo", bundle: Optional.none)
                        .resizable()
                        .scaledToFit().blur(radius: blurRadius)
                Image("f1_logo", bundle: Optional.none)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
        }
        .background(.gray.opacity(0.1))
    }
}

struct BackgroundViewContainer <Content: View>: View {

    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) { self.content = content }

    var body: some View {
        ZStack {
            BackgroundView(blurRadius: 50)
            content()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(blurRadius: 50.0)
    }
}
