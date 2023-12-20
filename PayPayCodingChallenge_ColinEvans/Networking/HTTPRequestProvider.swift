//
//  HTTPRequestProvider.swift
//  PayPayCodingChallenge_ColinEvans
//
//  Created by Colin Evans on 2023-12-14.
//

import Foundation

/// Models HTTP requests that can be issued by the client.
final class HTTPRequestProvider<R: Codable> {
  private let request: Resource<R>
  private let exchangeRequestActor: HTTPRequestFetchingActor

  init(
    request: Resource<R>,
    actor: HTTPRequestFetchingActor
  ) {
    self.request = request
    self.exchangeRequestActor = actor
  }
}

// MARK: - Extensions<OpenExchangeCurrencyProvider>
extension HTTPRequestProvider: HTTPRequestProviding {
  func getLatestExchangeRates() async throws  -> [Currency] {
    guard await !exchangeRequestActor.isFetching else {
      throw HTTPRequestError.fetchFailed
    }
    await exchangeRequestActor.updateIsFetching(to: true)
    
    do {
      let urlConfig = URLSessionConfiguration.default
      urlConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
      urlConfig.urlCache = nil
      let session = URLSession(configuration: urlConfig)
      guard let results = try await session.load(resource: request) as? CurrencyRates else {
        throw HTTPRequestError.incorrectDataResponse
      }
      await exchangeRequestActor.updateIsFetching(to: false)
      UserDefaults.standard.setValue(results.formatForUserDefaults(), forKey: "offline-currencies")
      return results.convert().sorted() { $0.id < $1.id }
    } catch {
      await exchangeRequestActor.updateIsFetching(to: false)
      throw error
    }
  }
}
