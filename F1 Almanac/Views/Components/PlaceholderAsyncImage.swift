//
//  PlaceholderAsyncImage.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 03..
//

import Foundation
import SwiftUI

struct PlaceholderableAsyncImage: View {
    var url: URL?
    var blurred: Bool = false

    var body: some View {
        AsyncImage(url: url, transaction: Transaction.init(animation: Animation.easeInOut)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Spacer().background(.gray).scaledToFit().padding(EdgeInsets.init(top: 0, leading: 8, bottom: 0, trailing: 8))
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            case .success(let image):
                ZStack {
                    if blurred {
                        image.resizable().scaledToFit().blur(radius: 50)
                    }
                    image.resizable().scaledToFit()
                }
            case .failure(_):
                Placeholder(blurred: blurred)
            @unknown default:
                Placeholder(blurred: blurred)
            }
        }
    }
}

struct Placeholder: View {
    var blurred: Bool = false
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if blurred {
                    Image("f1_logo", bundle: Optional.none)
                        .resizable()
                        .scaledToFit().blur(radius: 50)
                }
                Image("f1_logo", bundle: Optional.none)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
        }.background(.gray)
    }
}

struct PlaceholderableAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderableAsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Baku_Formula_One_circuit_map.png/1920px-Baku_Formula_One_circuit_map.png"), blurred: true).previewLayout(PreviewLayout.fixed(width: 375, height: 300))
    }
}

struct PlaceholderableAsyncImage_Failing_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderableAsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/tumb/6/6b/Baku_Formula_One_circuit_map.png/1920px-Baku_Formula_One_circuit_map.png"), blurred: true).previewLayout(PreviewLayout.fixed(width: 375, height: 300))
    }
}
