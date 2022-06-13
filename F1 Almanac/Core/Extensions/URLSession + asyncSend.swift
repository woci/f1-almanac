//
//  URLSession + asyncSend.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

public enum ResponseResult {
    case success(responseData: Data, response: URLResponse? = Optional.none)
    case error(error: Error)
}
extension JSONDecoder {
    static func decode<T: Codable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
extension URLSession {
    public func send(request: URLRequest) async -> ResponseResult {
        do {
            let result = try await data(for: request)

            let data = result.0
            let response = result.1

            return ResponseResult.success(responseData: data, response: response)
        } catch {
            return ResponseResult.error(error: error)
        }
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
