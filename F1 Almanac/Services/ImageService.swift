//
//  ImageService.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 03..
//

import Foundation
import UIKit

struct WikiImageService {
    func imageURL(of searchTerm: String, imageSize: CGFloat) async throws -> URL {
        let request = URLRequest(url: URL(string: "https://en.wikipedia.org/w/api.php?action=query&titles=\(searchTerm)&prop=pageimages&format=json&pithumbsize=\(Int(imageSize))")!)

        let result = await URLSession.shared.send(request: request)

        switch result {
        case .success(let responseData, _):
            let url = try (JSONDecoder.decode(data: responseData) as WikiMainImageResponse).query.pages.page.thumbnail.source
            return URL(string: url)!
        case .error(let error):
            throw error
        }
    }
}

