//
//  Resource.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

/// Groups a related endpoint `URL` with a parse function to map the `Data` into the concrete
/// type passed into the struct
struct Resource<A> {
  private let baseURL: URL
  
  /// The given `AppID` used in combition with the `URL` to fetch  results
  @AppIDProvider var appId: AppID
  
  /// The parse function unwraps the `Data` returned by the `URL` into the concrete data type
  let parse: (Data) throws -> A
  
  /// Builds the full `URL` combining the `AppID` with a base `URL`
  var url: URL {
    var url = URL(string: baseURL.absoluteString)!
    let queryItem = URLQueryItem(name: "app_id", value: appId.value)
    url.append(queryItems: [queryItem])
    return url
  }

  init(
    url: URL,
    parse: @escaping (Data) throws -> A,
    source: AppID.Source
  ) {
    self.parse = parse
    _appId = .init(source)
    self.baseURL = url
  }
}

// MARK: - Extensions: Convenience init
extension Resource where A: Codable {
  init(json url: URL, source: AppID.Source) {
    let parse = {
      try JSONDecoder().decode(A.self, from: $0)
    }
    self.init(url: url, parse: parse, source: source)
  }
}
