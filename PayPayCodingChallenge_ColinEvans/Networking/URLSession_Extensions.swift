//
//  URLSession_Extensions.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

extension URLSession {
  /// Performs a URL `GET` request for a given `Resource` and attempts to parse the results
  ///
  /// - Parameters:
  ///   - resource: A `Resource` with a concrete `Codable` type
  /// - Returns: `A` where `A` is a concrete `Codable` type provided by the `Resource`
  ///   or throws an `Error` if the data cannot be parsed
  func load<A>(resource r: Resource<A>) async throws -> A {
    let (data, response) = try await self.data(from: r.url)
    if let httpResponse = response as? HTTPURLResponse,
       (200...299).contains(httpResponse.statusCode) {
      return try r.parse(data)
    }
    throw URLError(.badServerResponse)
  }
}
